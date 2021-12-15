extends MeshInstance

func _on_Timer_timeout():
	var areas = $Area.get_overlapping_areas()
	for area in areas:
		area.damage(10)
	queue_free()
