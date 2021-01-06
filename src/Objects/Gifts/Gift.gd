extends Spatial
class_name Gift

var _player:Player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_shape_entered(body_id, body, body_shape, local_shape):
	GiftData.set_current(self)


func _on_shape_exited(body_id, body, body_shape, local_shape):
	GiftData.set_current(null)
