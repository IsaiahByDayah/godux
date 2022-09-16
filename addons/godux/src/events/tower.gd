class_name GoduxTower
extends RefCounted


func _init():
	print("[Godux Tower] ** Initializing! **")


func listen(channel: String, target, method):
	if !has_signal(channel):
		add_user_signal(channel, [{ "name": "payload", "type": TYPE_DICTIONARY}])
	connect(channel,Callable(target,method))


func disconnect(channel: String,Callable(target,method)):
	if has_signal(channel):
		disconnect(channel,Callable(target,method))


func broadcast(channel: String, message: Dictionary = {}) -> void:
	# Channel check
	if !has_signal(channel):
		printerr("[Godux Tower] - Invalid broadcast: unrecognized channel. %s" % channel)
		return
	
	emit_signal(channel, message)
