class_name GoduxStore
extends Reference


signal changed


var _slices := {}
var _state := {} setget ,get_state


func _init(slices: Array) -> void:
	for slice in slices:
		_register_slice(slice)


func get_state() -> Dictionary:
	return _state


func subscribe(target, method):
	connect('changed', target, method)


func unsubscribe(target, method):
	disconnect('changed', target, method)


func _register_slice(slice: GoduxSlice) -> void:
	_slices[slice.name] = slice
	_state[slice.name] = slice.initial_state


func dispatch(action: Dictionary) -> void:
	# Action check
	if !action or !action.has("type") or !action.type is String:
		printerr("[Godux Store] - Invalid dispatch action: missing type property. %s" % action)
		return
	
	var type = action.type
	var slice_name = type.get_slice("/", 0)
	
	# Slice check
	if !slice_name or !_slices.has(slice_name):
		printerr("[Godux Store] - Invalid dispatch action: could not resolve slice from action. %s" % action)
		return
	
	var slice = _slices[slice_name] as GoduxSlice
	var slice_state = _state[slice_name]
	
	var reducer_name = type.get_slice("/", 1)
	var reducer_ref = slice.reducers[reducer_name] as FuncRef
	
	# Reducer check
	if !reducer_name or !reducer_ref or !reducer_ref is FuncRef or !reducer_ref.is_valid():
		printerr("[Godux Store] - Invalid dispatch action: could not resolve reducer for action. %s" % action)
		return
	
	var new_slice_state = reducer_ref.call_func(slice_state, action)
	
	print_debug("[Godux Store] reducing new %s state..." % slice_name)
	_state[slice_name] = new_slice_state
	
	emit_signal("changed")
	





