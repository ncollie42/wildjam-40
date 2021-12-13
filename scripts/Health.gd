extends Area

signal push_back(direction, strength, speed)
signal died()
signal hurt(amount)

export(global.unit_type) var unit_type = global.unit_type.HERO
export(int) var hp = 3 #change to a resource
#
func _ready():
	global.set_collison_type(self, unit_type)

func damage(amount):
	hp -= amount
	#TODO: signal damaged -> damage number or local
	print("Hit: ", amount, " HP: ", hp)
	emit_signal("hurt",amount)
	if hp <= 0:
		get_parent().queue_free()
		emit_signal("died")

func push_back(direction : Vector2, strength, speed):#TODO: call signal dirrectly from the projectile
	"""
	Animation_tree having BlendSpace2D for pushback in a condenced to vector of 1
		strength: 1 being max, 1/2, 1/5 of original distance
		Speed: 1 being normal, 2, 5 times faster of original speed. 
	"""
	emit_signal("push_back", direction, strength, speed)
