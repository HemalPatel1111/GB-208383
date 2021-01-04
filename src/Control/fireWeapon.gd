extends Control
class_name FireWeapon

var _player:Player = null

var press_color:Color = Color(0.8,0.8,0.8,0.8)
var normal_color:Color = Color(1.0,1.0,1.0,1.0)


func set_Player(player:Player):
	_player = player

var index:= -1

func _touch_started(e:InputEventScreenTouch) -> bool:
	return e.pressed and index == -1
	
func _touch_ended(e:InputEventScreenTouch) -> bool:
	return not e.pressed and index == e.index

func _holded(e: InputEventScreenTouch) -> bool:
	return get_rect().has_point(e.position)

func _input(event):
	if not (event is InputEventScreenTouch or event is InputEventScreenDrag):
		return
		
	if event is InputEventScreenTouch:
		var e:InputEventScreenTouch = event
		
		if _touch_started(e) and _holded(e):
			index = e.index
			self.modulate = press_color
		elif _touch_ended(e):
			index = -1
			self.modulate = normal_color

func _on_TouchScreenButton_pressed():
	if _player != null:
		_player.fireIt(true)

func _on_TouchScreenButton_released():
#	if _player != null:
#		_player.fireIt(false)
	pass
