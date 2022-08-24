class_name GoduxRadio
extends Reference


var _channel: String

var active: bool = true
var callback: FuncRef


func _init(channel: String, target, method) -> void:
	print("[Godux Radio] ** Initializing! **")
	callback = funcref(target, method)
	Godux.tower.listen(channel, self, "_on_message")


func _on_message(message: Dictionary):
	if active and callback.is_valid():
		callback.call_func(message)
