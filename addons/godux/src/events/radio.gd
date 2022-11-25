class_name GoduxRadio
extends RefCounted


var _channel: String

var mute: bool = false


func _init(channel: String,target,method):
	print("[Godux Radio] ** Initializing! **")
	Godux.tower.listen(channel, self._on_message)


func _on_message(message: Dictionary):
	if active and callback.is_valid():
		callback.call_func(message)
