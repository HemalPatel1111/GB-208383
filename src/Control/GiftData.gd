extends Node

#Constant throught levels
var gifts_icons:PoolStringArray = PoolStringArray()

var loaded:= false

var _gift:Gift= null
var _player:Player = null
var points:int = -1

var UP:  Vector3 = Vector3(0,1,0) #Camera UP direction
var Look:Vector3 = Vector3()	 #Camera Look direction
var Left:Vector3 = Vector3()	 #Camera Left direction

func set_Player(player:Player):
	_player = player

func set_current(gift:Gift):
	_gift = gift
	if gift != null:
		_gift = gift
		if _gift != null:
				var _name:= _gift.name
				var _index = int(_name.to_lower().replace("gift","")) - 1
				_gift.queue_free()
				_gift = null
				_player.up_health(5)
				points += 5
				GiftData.set_current(null)

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
