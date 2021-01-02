extends Button
#      store  Input
#      type   type
export var nextScene:PackedScene = null

func _on_Button_pressed():
	var err:int = get_tree().change_scene_to(nextScene)

func _get_configuration_warning() -> String:
	return "nextScene must be set for button to work" if nextScene == null else ""
