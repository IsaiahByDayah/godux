class_name GoduxTower
extends RefCounted


func _init():
	print("[Godux Tower] ** Initializing! **")


func listen(channel: String, callback: Callable) -> Callable:
	if !has_signal(channel):
		add_user_signal(channel, [{ "name": "payload", "type": TYPE_DICTIONARY}])
	connect(channel, callback)
	return func(): self.disconnect(channel, callback)


func broadcast(channel: String, message: Dictionary = {}) -> void:
	if !has_signal(channel):
		printerr("[Godux Tower] - Invalid broadcast: unrecognized channel. %s" % channel)
		return
	
	emit_signal(channel, message)
