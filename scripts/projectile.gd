extends KinematicBody


export(float, 0, 100) var speed := 15.0
export(global.push_back_speed) var push_back_speed = global.push_back_speed.MAX
export(global.push_back_strength) var push_back_strength = global.push_back_strength.LOW

func _physics_process(delta: float):
	var col := move_and_collide(global_transform.basis.z * speed * delta)
	if col:
		print("Hit a wall ", col.collider.name)
		queue_free()

func _on_Timer_timeout():
	queue_free()

func _on_Area_area_entered(enemy_health):
#	var direction := Vector2(global_transform.basis.z.x, global_transform.basis.z.z)
	enemy_health.emit_signal("push_back", global_transform.basis.z, push_back_strength, push_back_speed)
	enemy_health.damage(1)
	queue_free()
