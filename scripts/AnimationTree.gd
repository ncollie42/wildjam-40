extends AnimationTree

#Use to know at what % current animation is at
#Cacel current animation
var connections :Dictionary = {} #ability_name[node_names]
var playbacks : Array = []
var RESET = 6
func _ready():
	"""
	Node connections returns an array:
		single entry: node, current value, connection 
	"""
	var connections_list = tree_root.get("node_connections")
	var ii := 0
	while(ii < len(connections_list)):
		var node = connections_list[ii]
		var value = connections_list[ii+1]
		var link = connections_list[ii+2]
		ii += 3
		if !connections.has(node):
			connections[node] = []
		connections[node].append(link)
	for ability_name in connections["ability_name"]:
		playbacks.append(get("parameters/"+ability_name+"/playback"))
	RESET = len(playbacks) - 1

func enable_ability(index: int):
	"""
	Updates transition node for correct spell index
	"""
	print("Casting: ", connections["ability_name"][index])
	set("parameters/ability_name/current", index)
	set("parameters/ability/active", true)

var CANT_SKIP_ANIM = ["SEARING_FLIGHT"]#TODO: make more dynamic
func cancel_ability():
	var index = get("parameters/ability_name/current")
	var ability = connections["ability_name"][index]
	if ability in CANT_SKIP_ANIM:
		return
	set("parameters/ability_name/current", RESET)

func is_playing_ability() -> bool:
	if !is_current_anim_done():
		return true
	return false

func is_current_anim_done():
	"""
	Get current animation length and position
	Not used for now.
	"""
	var index = get("parameters/ability_name/current")
	var leng = playbacks[index].get_current_length()
	var pos = playbacks[index].get_current_play_position()
	if is_equal_approx(pos, leng):
		return true
	print("Currently casting ", connections["ability_name"][index], " ", pos, "/", leng)
	return false
#
#
#func tmp():
#	var current_spell = get("parameters/ability_name/current")
#	var leng = playbacks[current_spell].get_current_length()
#	var pos = playbacks[current_spell].get_current_play_position()
#	print("Currently:", connections["ability_name"][current_spell], ": ", current_spell, " ", pos, "/", leng)
#
#
#func _physics_process(delta):
#	tmp()
