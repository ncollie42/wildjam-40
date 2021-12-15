extends MeshInstance

onready var labels = []
onready var playbacks = []

var index = 0

func _ready():
	for label in $Viewport/Control/labels.get_children():
		labels.append(label)
		playbacks.append(label.get_child(0))

func _on_Health_hurt(amount):
	print("Hurt: ", amount, index)
	labels[index].text = str(amount)
	playbacks[index].play("damage")
	index = wrapi(index + 1, 0, len(playbacks))


func _on_Health_stun():
	$Viewport/Control/stunned/AnimationPlayer.play("stun")
