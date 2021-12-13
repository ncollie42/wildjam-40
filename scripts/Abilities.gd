extends Spatial

export(global.unit_type) var unit_type = global.unit_type.HERO
export(Array, Resource) var ability_resources = []

var mouse_position : Vector3 = Vector3.ZERO #Gets updated from model
var current_ability = null #Value set by parent

var _visualizer = null
# Spells [q][r][f][ability resource][ability resource][] -> Allow keybind remap by index, allow abillity move by resource index move.
#Input_node (Signal spell index w/ mouse location) -> Trigger animation tree one shot for spell  (Update witch for spell w/ transition)-> Animation calls correct spawnning method
func _ready():
	for ability in ability_resources:
		if !ability:
			continue
		add_timer(ability.cd)

func _process(_delta):
	if _visualizer:
		_visualizer.global_transform.origin = mouse_position

func spawn_visualizer():
	var visualizer: Spatial = ability_resources[current_ability].visualizer.instance()
	get_tree().current_scene.add_child(visualizer)
	visualizer.global_transform.origin = mouse_position
	_visualizer = visualizer
	
func remove_visualizer():
	if _visualizer:
		_visualizer.queue_free()
		_visualizer = null

func spawn_at_target_pos():
	var ability: Spatial = ability_resources[current_ability].ability.instance()
	global.set_collison_type(ability.get_node("Area"), unit_type)
	get_tree().current_scene.add_child(ability)
	ability.global_transform.origin = mouse_position


func spawn_at_self():
	var ability: Spatial = ability_resources[current_ability].ability.instance()
	global.set_collison_type(ability.get_node("Area"), unit_type)
	ability.global_transform = global_transform
	get_tree().current_scene.add_child(ability)
	
func add_timer(cd:float):
	var timer = Timer.new()
	timer.wait_time = cd
	timer.one_shot = true
	add_child(timer)
