extends Control
class_name PickeButton

var _player:Player = null
var gifts:PoolStringArray = PoolStringArray()

var press_color:Color = Color(0.8,0.8,0.8,0.8)
var normal_color:Color = Color(1.0,1.0,1.0,1.0)

signal gift_picked(gift_index)

func set_Player(player:Player):
	_player = player

var index:= -1
var giftIndex = -1
var _gift:Gift = null

func _got_Gift(gift:Gift):
	_gift = gift
	
func _deny_Gift():
	_gift = null

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
			if _gift != null:
				var _name:= _gift.name
				var _index = int(_name.to_lower().replace("gift","")) - 1
				_gift.queue_free()
				_gift = null
				
				emit_signal("gift_picked", _index)
		elif _touch_ended(e):
			index = -1
