class_name GoduxTower
extends Reference


func listen(channel: String, target, method):
	if !has_signal(channel):
		add_user_signal(channel, [{ "name": "payload", "type": TYPE_DICTIONARY}])


func disconnect(channel: String, target, method):
	if has_signal(channel):
		disconnect(channel, target, method)


func broadcast(channel: String, message: Dictionary = {}) -> void:
	# Channel check
	if !has_signal(channel):
		printerr("[Godux Tower] - Invalid broadcast: unrecognized channel. %s" % channel)
		return
	
	emit_signal(channel, message)
