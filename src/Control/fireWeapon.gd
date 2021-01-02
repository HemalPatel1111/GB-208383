extends TextureButton
class_name FireWeapon

var _player:Player = null

func set_Player(player:Player):
	_player = player


func _on_fireWeapon_button_down():
	if _player != null:
		_player.fireIt(true)
