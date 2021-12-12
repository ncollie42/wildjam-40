extends Spatial

signal updated_root_motion_direction(direction)
var mouse_position:Vector3 = Vector3.ZERO

func _on_Player_input_look_towards(_mouse_position : Vector3):
	mouse_position = _mouse_position
	model_look_at(_mouse_position)

func model_look_at(position: Vector3):
	"""
	Update rotation matrix based on look at position
	
	Signal from: player_input / enemy_input
	"""
	var dir_to = global_transform.origin.direction_to(position)
	var target_rad = atan2(dir_to.x, dir_to.z)
	var dif_rad = target_rad - rotation.y 
	
	var blend_position_v2 = $AnimationTree.get("parameters/move/blend_position")
	var blend_position_v3 = global_transform.basis.xform(Vector3(-blend_position_v2.x,0,blend_position_v2.y))
	
	global_transform.basis = global_transform.basis.rotated(Vector3.UP, dif_rad)
	#Update current blend position according to new direction
	blend_position_v3 = global_transform.basis.xform_inv(blend_position_v3)

	$AnimationTree.set("parameters/move/blend_position", Vector2(-blend_position_v3.x, blend_position_v3.z))

func _on_Movement_updated_velocity(velocity):
	"""
	Update walk animation based on velocity;
		transform the velocity relative to the direction our feet are facing 

	Signal from: Movement
	"""
	var local_velocity := global_transform.basis.xform_inv(velocity)
	var blend_position = Vector2(-local_velocity.x, local_velocity.z)

	$AnimationTree.set("parameters/move/blend_position", blend_position)

func _physics_process(delta):
	#force animation step on current frame
	$AnimationTree.advance(delta) #Need physics mode to be manual
	var root_motion_origin = $AnimationTree.get_root_motion_transform().origin#Displacement delta_x
	var true_velocity = global_transform.basis.xform(root_motion_origin) / delta

	emit_signal("updated_root_motion_direction", true_velocity)
