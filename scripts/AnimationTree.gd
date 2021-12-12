extends AnimationTree

func enable_ability(index: int):
	"""
	Updates transition node for correct spell index
	"""
	print("Casting: ", index)
	set("parameters/ability_name/current", index)
	set("parameters/ability/active", true)
