tool
extends Control


const CONFIG_PATH: String = "res://addons/godux/config.tres"

var config: GoduxConfig
var local_config: GoduxConfig
var changed: bool = false

onready var slices_folder_file_dialog: FileDialog = $SlicesFolderFileDialog
onready var slices_folder_line_edit: LineEdit = $VBoxContainer/HBoxContainer/LineEdit
onready var save_button: Button = $VBoxContainer/SaveButton


func _ready() -> void:
	load_config()
	local_config = config.duplicate()
	set_fields()


func load_config() -> void:
	config = ResourceLoader.load(CONFIG_PATH, "", true)


func set_fields() -> void:
	slices_folder_line_edit.text = local_config.slices_directory_path
	save_button.disabled = !changed


func _on_config_changed() -> void:
	set_fields()


func _on_SlicesFolderSelectButton_pressed() -> void:
	slices_folder_file_dialog.popup_centered()


func _on_SlicesFolderFileDialog_dir_selected(dir: String) -> void:
	local_config.slices_directory_path = dir
	changed = true
	set_fields()


func _on_SaveButton_pressed() -> void:
	ResourceSaver.save(CONFIG_PATH, local_config)
	load_config()
	print("Slice Path: %s" % config.slices_directory_path)
	changed = false
	set_fields()
