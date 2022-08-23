class_name GoduxRadio
extends Reference


var active: bool = true
var callback: FuncRef


func _init(channel: String, target, method) -> void:
	callback = funcref(target, method)
	Godux.tower.listen(channel, self, "_on_message")


func _on_message(message: Dictionary):
	if active:
		callback.call_func(message)
