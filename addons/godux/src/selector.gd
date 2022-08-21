class_name GoduxSelector
extends Reference


signal changed


var select_func: FuncRef
var is_equal_func: FuncRef
var state = null


func _init(initial_select_func: FuncRef, is_state_equal_func: FuncRef = null) -> void:
	Godux.store.connect("changed", self, "_on_store_changed")
	set_select_func(initial_select_func)
	is_equal_func = is_state_equal_func


func set_select_func(new_select_func: FuncRef):
	select_func = new_select_func
	state = _select()


func _select():
	if select_func and select_func.is_valid():
		return select_func.call_func(Godux.store.get_state())
	return null


func _on_store_changed():
	var new_state = _select()
	print_debug("[Selector] store state changed...")
	var state_changed = state != new_state
	if is_equal_func and is_equal_func.is_valid():
		state_changed = !is_equal_func.call_func(state, new_state)
	if state_changed:
		print_debug("[Selector] ... and selector state changed!")
		state = new_state
		emit_signal("changed")
	else:
		print_debug("[Selector] ... but selector state didn't change.")

