tool
extends EditorPlugin
var dock

func _enter_tree():

	# Initialization of the plugin goes here.
	# Load the dock scene and instance it.
	dock = preload("res://addons/root_motion/dock.tscn").instance()
	dock.EI = get_editor_interface()
	# Add the loaded scene to the docks.
	add_control_to_dock(DOCK_SLOT_LEFT_BR, dock)
#	connect("scene_changed", dock, "_on_scene_changed")
	
func _exit_tree():
	# Clean-up of the plugin goes here.
	# Remove the dock.
	remove_control_from_docks(dock)
	# Erase the control from the memory.
	dock.free()
