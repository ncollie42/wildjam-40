extends Reference
class_name global


enum push_back_strength {MAX=1, MID=2, LOW=10}
enum push_back_speed {LOW=1, MID=2, MAX=10}
enum unit_type {HERO=4,ENEMY=8} #This matches the physics layer

static func set_collison_type(obj : CollisionObject, type : int):
	obj.collision_layer = type
	obj.collision_mask = unit_type.ENEMY if (type == unit_type.HERO) else unit_type.HERO
	print(obj.collision_mask," ", obj.collision_layer)
	
