extends Spatial
class_name Gift

var _player:Player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_body_entered(body):
	print_debug(body.name)
	GiftData.set_current(self)


func _on_body_exited(body):
	GiftData.set_current(null)
