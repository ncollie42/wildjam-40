extends CollisionShape

const GRAVITY := 9.8
export(int) var ACCEL := 20 #Velocity / time -> distance/animation speed -> 3/.7
export(int) var MAX_SPEED := 6.0 #Max speed is fixed to root motion speed

var velocity := Vector3.ZERO
var move_dir := Vector3.ZERO

signal updated_velocity(velocity)

func _on_Player_input_move_towards(_dir):
	"""
	Signal from: player_input
	"""
	move_dir = _dir * MAX_SPEED

func update_velocity(delta):
	"""
	Accelerate towards desired velocity:
		Real speed is based on animation, this velocity is input for blendtree.
	"""
	velocity.x = move_toward(velocity.x, move_dir.x, ACCEL * delta)
#	velocity.y -= GRAVITY * delta
	velocity.z = move_toward(velocity.z, move_dir.z, ACCEL * delta)
#	print("Updated Velocity: ", velocity)
	emit_signal("updated_velocity", velocity)

func _physics_process(delta):
	update_velocity(delta)
	

func _on_Model_updated_root_motion_direction(final_velocity):
	"""
	Signal from: Model
		(final_velocity - velocity) / delta(0.016667) == Acceleration(ACCEL)
	"""
#	if !is_on_floor():
#		direction.y = -GRAVITY
#	print("Final: ", final_velocity, " speed: ", final_velocity.length())
	velocity = get_parent().move_and_slide(final_velocity, Vector3.UP)
