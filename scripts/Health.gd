extends Area

signal push_back(direction, strength, speed)
signal died()
signal hurt(amount)

export(int) var hp = 3 #change to a resource

func damage(amount):
	hp -= amount
	#TODO: signal damaged -> damage number or local
	print("Hit: ", amount, " HP: ", hp)
	emit_signal("hurt",amount)
	if hp <= 0:
		emit_signal("died")

func push_back(direction : Vector2, strength, speed):#TODO: call signal dirrectly from the projectile
	"""
	Animation_tree having BlendSpace2D for pushback in a condenced to vector of 1
		strength: 1 being max, 1/2, 1/5 of original distance
		Speed: 1 being normal, 2, 5 times faster of original speed. 
	"""
	emit_signal("push_back", direction, strength, speed)
