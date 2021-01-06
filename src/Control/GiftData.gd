extends Node


#Constant throught levels
var gifts_icons:PoolStringArray = PoolStringArray()

var loaded:= false

# Called when the node enters the scene tree for the first time.
func _ready():
	load_data()

func load_data():
	if not loaded:
		gifts_icons.append("res://assets/Textures/gift.png")
		loaded = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
