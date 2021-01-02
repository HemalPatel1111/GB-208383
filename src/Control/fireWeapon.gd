extends Control
class_name FireWeapon

var _player:Player = null

func set_Player(player:Player):
	_player = player

func _on_TouchScreenButton_pressed():
	if _player != null:
		_player.fireIt(true)

func _on_TouchScreenButton_released():
#	if _player != null:
#		_player.fireIt(false)
	pass
