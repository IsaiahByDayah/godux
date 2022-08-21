extends Node


const CONFIG: GoduxConfig = preload("res://addons/godux/config.tres")

var store: GoduxStore


func _ready() -> void:
	store = GoduxStore.new()
	register_slices()
	print_debug("[Godux] Initial Store: %s" % store.get_state())


func register_slices() -> void:
	if !CONFIG.slices_directory_path:
		printerr("[Godux] Unable to load slices: missing slices_directory_path in config - %s" % CONFIG.slices_directory_path)
		return
	
	var slices_dir = Directory.new()
	slices_dir.open(CONFIG.slices_directory_path)
	slices_dir.list_dir_begin(true, true)

	var slice_filename = slices_dir.get_next()
	while slice_filename != "":
		var slice_path = CONFIG.slices_directory_path + "/" + slice_filename
		var slice = load(slice_path).new() as GoduxSlice
		store.register_slice(slice)
		slice_filename = slices_dir.get_next()

