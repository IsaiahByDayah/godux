class_name GoduxAction
extends RefCounted


var type: String
var payload


func _init(_type: String, _payload = null):
	type = _type
	payload = _payload
