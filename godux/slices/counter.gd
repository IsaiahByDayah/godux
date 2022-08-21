extends GoduxSlice


const ActionType = {
	INCREMENT = "increment",
	DECREMENT = "decrement",
	RESET = "reset",
}


func _init() -> void:
	name = "counter"
	initial_state = {
		"value": 0,
	}
	reducers = {}
	for type in ActionType:
		reducers[ActionType[type]] = funcref(self, "reduce_%s" % ActionType[type])


func reduce_increment(state: Dictionary, action: Dictionary):
	var new_state = state.duplicate()
	new_state.value += action.payload
	return new_state


func reduce_decrement(state: Dictionary, action: Dictionary):
	var new_state = state.duplicate()
	new_state.value -= action.payload
	return new_state


func reduce_reset(state: Dictionary, _action: Dictionary):
	var new_state = state.duplicate()
	new_state.value = 0
	return new_state


static func action_increment(amount = 1) -> Dictionary:
	return {
		"type": "counter/"+ActionType.INCREMENT,
		"payload": amount
	}


static func action_decrement(amount = 1) -> Dictionary:
	return {
		"type": "counter/"+ActionType.DECREMENT,
		"payload": amount
	}


static func action_reset() -> Dictionary:
	return {
		"type": "counter/"+ActionType.RESET,
	}
