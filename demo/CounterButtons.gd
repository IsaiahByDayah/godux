extends HBoxContainer


const CounterSlice = preload("res://godux/slices/counter.gd")


onready var subtract_1_button: Button = $Subtract1Button
onready var add_1_button: Button = $Add1Button
onready var add_5_button: Button = $Add5Button
onready var reset_button: Button = $ResetButton


func _ready() -> void:
	subtract_1_button.connect("pressed", Godux.store, "dispatch", [CounterSlice.action_decrement()])
	
	add_1_button.connect("pressed", Godux.store, "dispatch", [CounterSlice.action_increment()])
	
	add_5_button.connect("pressed", Godux.store, "dispatch", [CounterSlice.action_increment(5)])
	
	reset_button.connect("pressed", Godux.store, "dispatch", [CounterSlice.action_reset()])
