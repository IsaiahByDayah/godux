extends Node


const CONFIG: GoduxConfig = preload("res://addons/godux/config.tres")

var tower: GoduxTower
var store: GoduxStore


func _ready() -> void:
	# Tower setup
	tower = GoduxTower.new()
	
	# Store setup
	var slices = load_slices()
	store = GoduxStore.new(slices)
	print_debug("[Godux] Initial Store: %s" % store.get_state())


func load_slices() -> Array:
	var slices = []
	
	if !CONFIG.slices_directory_path:
		printerr("[Godux] Unable to load slices: missing slices_directory_path in config - %s" % CONFIG.slices_directory_path)
		return []
	
	var slices_dir = Directory.new()
	slices_dir.open(CONFIG.slices_directory_path)
	slices_dir.list_dir_begin() # TODOGODOT4 fill missing arguments https://github.com/godotengine/godot/pull/40547

	var slice_filename = slices_dir.get_next()
	while slice_filename != "":
		var slice_path = CONFIG.slices_directory_path + "/" + slice_filename
		var slice = load(slice_path).new() as GoduxSlice
		slices.append(slice)
		slice_filename = slices_dir.get_next()
	
	return slices

