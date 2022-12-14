extends Label


onready var selector := GoduxSelector.new(funcref(self, "select_state"))


func _ready() -> void:
	selector.subscribe(self, "render")
	render(true)


func render(initial = false):
	if initial:
		print_debug("[Counter Label] Initial Render")
	else:
		print_debug("[Counter Label] Re-rendering!")
		
	var count = selector.state
	text = "Count: %s" % count
	if count < 0:
		set("modulate", Color.red)
	elif count == 0:
		set("modulate", Color.white)
	else:
		set("modulate", Color.green)


func select_state(state):
	return state.counter.value

