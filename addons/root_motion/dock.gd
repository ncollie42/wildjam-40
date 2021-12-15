tool
extends Control

func _on_Button_pressed():
	edit_animations()

var target_animation_player = null
var EI = null #EditorInterface 

func _ready():
	EI.get_selection().connect("selection_changed", self, "selection_change")
	selection_change()

func selection_change():
	#Select the animation player from selected node
	for node in EI.get_selection().get_selected_nodes():
		if node is AnimationPlayer:
			target_animation_player = node
			_update_tree()
			return

func _update_tree():
	$VBoxContainer/Tree.clear()
	var root = $VBoxContainer/Tree.create_item()
	root.set_text(0, "AnimationPlayer") #Set Icon?
	var test = $VBoxContainer/Tree.create_item(root)
	test.set_text(0, EI.name)
	for animation in target_animation_player.get_animation_list():
		var child = $VBoxContainer/Tree.create_item(root)
		child.set_text(0, animation)

var name_to_pos = {"forward":Vector3(0,0,5),
 "backward": Vector3(0,0,-5),
 "right" : Vector3(-5,0,0),
 "left" : Vector3(5,0,0),
}
func edit_animations():
	for animation_name in name_to_pos.keys():
		edit_animation(animation_name)
	_update_tree()

func edit_animation(animation_name):
	var animation :Animation = target_animation_player.get_animation(animation_name)
	#Add transform track
#	var id = animation.find_track(".:RM")#Could this this a beter name I.E: .:root_motion
#	if id != -1:
#		print(animation_name, " ", id, " Already has track") #TODO: Update value, use vectors of 1, I.E (1,0,0) * 5
#		return
	var track_index = animation.add_track(Animation.TYPE_TRANSFORM)
	animation.track_set_path(track_index, ".:root_motion")
	animation.transform_track_insert_key(track_index, 0.0, Vector3.ZERO, Quat(), Vector3.ONE)
	animation.transform_track_insert_key(track_index, 1, name_to_pos[animation_name], Quat(), Vector3.ONE)
	#Add animation for push
	var dup_animation = animation.duplicate()

	target_animation_player.add_animation(animation_name + "_push", dup_animation)
	#Loop WASN animations
	animation.loop = true


#TODO: 
# Update scale to 1.5
# Create key frames for updated speed
# Create key frames for chanrge in state after animation
