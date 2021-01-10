extends Spatial

export var nextScene:PackedScene = null


func _on_StaticBody_body_entered(body):
	print_debug(body.name)
	if body.name[1] != "r":
		get_tree().change_scene_to(nextScene)
