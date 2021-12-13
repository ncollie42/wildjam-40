extends Camera

const ray_length = 20

signal look_towards(position)
signal move_towards(move_dir)
signal cast_spell(index)

func keyboard_input():
	var from = project_ray_origin(get_viewport().get_mouse_position())
	var to = from + project_ray_normal(get_viewport().get_mouse_position()) * ray_length
	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(from, to, [], $look_at_plane.collision_layer)
	if result:
		emit_signal("look_towards", result.position)

	var input_vect := Input.get_vector("right", "left", "backwards", "forwards")

	emit_signal("move_towards", Vector3(input_vect.x, 0 , input_vect.y))
	if Input.is_action_just_pressed("fireball") and result:
		emit_signal("cast_spell", 0)
	if Input.is_action_just_pressed("firestorm") and result:
		emit_signal("cast_spell", 1)

func _physics_process(_delta):
	keyboard_input()

# 1. Input(input_vector) ->
# 2. Update velocity by ACCEL towards new input_vect ->
# 3. Convert velocity to local model feet direction ->
# 4. Convert root_motion into velocity for move_and_slide
