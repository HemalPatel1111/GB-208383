extends Control
class_name JumpButton,  "res://src/Control/JumpButton.gd"

var _player:Player = null
var gifts:PoolStringArray = PoolStringArray()

var press_color:Color = Color(0.8,0.8,0.8,0.8)
var normal_color:Color = Color(1.0,1.0,1.0,1.0)

func set_Player(player:Player):
	_player = player

var index:= -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
			if _player.get_weapon() == Weapon.RIFLE:
				_player.play_animation("Rifle Jump Up")
			if _player.get_weapon() == Weapon.HAND:
				_player.play_animation("Jump")
			if _player.get_weapon() == Weapon.PISTOL:
				_player.play_animation("Pistol Jump")
		elif _touch_ended(e):
			index = -1
			if _player.get_weapon() == Weapon.RIFLE:
				_player.play_animation("Rifle Jump Down")
