tool
extends EditorPlugin


const MANAGEMENT_PANEL_SCENE = preload("res://addons/godux/nodes/management_panel.tscn")

var management_panel: Control


func _enter_tree() -> void:
	management_panel = MANAGEMENT_PANEL_SCENE.instance()
	get_editor_interface().get_editor_viewport().add_child(management_panel)
	make_visible(false)
	
	add_autoload_singleton("Godux", "res://addons/godux/nodes/godux.gd")


func _exit_tree() -> void:
	if management_panel:
		management_panel.queue_free()


func has_main_screen() -> bool:
	return true


func make_visible(visible: bool) -> void:
	if management_panel:
		management_panel.visible = visible


func get_plugin_name() -> String:
	return "Godux"


func get_plugin_icon() -> Texture:
	return get_editor_interface().get_base_control().get_icon("ParticleAttractor2D", "EditorIcons")

