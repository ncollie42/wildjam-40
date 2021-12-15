extends Node

func init_anim(animPlayer : AnimationPlayer, distance: float):
	"""
	Only used by searing flight
	Contains extra information
	
	Other spells could be moved into here to
	init
	use
	update
	"""
	#get animation, update distance
	#
	var anim : Animation = animPlayer.get_animation("SEARING_FLIGHT_2")
	var id := anim.find_track(".:root_motion")
	var key_count := anim.track_get_key_count(id)
	print("ID ", id, " ", key_count, " distance: ", distance, " lengh: ", anim.length)
	if key_count == 3:
		anim.track_remove_key(id, 2)
		anim.transform_track_insert_key(id, .6, Vector3.BACK * distance, Quat(), Vector3.ONE)
