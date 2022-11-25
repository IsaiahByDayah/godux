class_name GoduxStore
extends RefCounted


const DEFAULT_CHANNEL: String = "GODUX_STORE-DEFAULT_CHANNEL"


var _channel := DEFAULT_CHANNEL
var _slices := {}
var _state := {} :
	get:
		return _state # TODOConverter40 Copy here content of get_state 


func _init(slices: Array, channel: String = DEFAULT_CHANNEL):
	print("[Godux Store] ** Initializing! **")
	_channel = channel
	for slice in slices:
		_register_slice(slice)


func get_state() -> Dictionary:
	return _state


func get_channel() -> String:
	return _channel


func subscribe(target, method):
	Godux.tower.listen(_channel, target, method)


func unsubscribe(target, method):
	Godux.tower.disconnect(_channel,Callable(target,method))


func dispatch(action: GoduxAction) -> void:
	var type = action.type
	var slice_name = type.get_slice("/", 0)
	
	# Slice check
	if !slice_name or !_slices.has(slice_name):
		printerr("[Godux Store] - Invalid dispatch action: could not resolve slice from action. %s" % action)
		return
	
	var slice = _slices[slice_name] as GoduxSlice
	var slice_state = _state[slice_name]
	
	var reducer_name = type.get_slice("/", 1)
	var reducer_ref = slice.reducers[reducer_name] as Callable
	
	# Reducer check
	if !reducer_name or !reducer_ref or !reducer_ref is Callable or !reducer_ref.is_valid():
		printerr("[Godux Store] - Invalid dispatch action: could not resolve reducer for action. %s" % action)
		return
	
	var new_slice_state = reducer_ref.call_func(slice_state, action)
	
	print_debug("[Godux Store] reducing new %s state..." % slice_name)
	_state[slice_name] = new_slice_state
	
	Godux.tower.broadcast(_channel)


func _register_slice(slice: GoduxSlice) -> void:
	_slices[slice.name] = slice
	_state[slice.name] = slice.initial_state




