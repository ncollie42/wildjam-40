extends Viewport

var player : Spatial = null

func _ready():
	player = get_node("../player")

var offset = Vector2(1000,1000)#Half viewport to offset
func _physics_process(delta):
	var pos_3 = player.global_transform.origin
	var pos_2 = Vector2(pos_3.x, pos_3.z) * 40 #Ratio of base -> viewport
	pos_2 = pos_2 + offset
#	print($Icon.position.distance_to(pos_2))
#	if $Icon.position.distance_to(pos_2) < 20:
#		return
	$Icon.position = pos_2
