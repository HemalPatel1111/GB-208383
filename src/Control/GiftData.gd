extends Node

#Constant throught levels
var gifts_icons:PoolStringArray = PoolStringArray()

var loaded:= false

var _gift:Gift= null
var _button:PickButton = null

func set_pick_button(button:PickButton):
	_button = button

func set_current(gift:Gift):
	_gift = gift
	if gift != null:
		_gift = gift
		_button.got_Gift(gift)
	else:
		_button.deny_Gift()

# Called when the node enters the scene tree for the first time.
func _ready():
	load_data()

func load_data():
	if not loaded:
		gifts_icons.append("res://assets/Textures/gifts/gift.png")
		gifts_icons.append("res://assets/Textures/gifts/gift1.png")
		gifts_icons.append("res://assets/Textures/gifts/gift2.png")
		gifts_icons.append("res://assets/Textures/gifts/gift3.png")
		loaded = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
