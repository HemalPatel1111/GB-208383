extends Control
class_name GiftButton

var index:= -1
var texture:=ImageTexture.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Icon.set_texture(texture)
	$Label.text = "Gift " + str(index + 1)
	
func load_gift(id:int, type_id:int):
	GiftData.load_data()
	var path:String= GiftData.gifts_icons[type_id - 1]
	var texture:=ImageTexture.new()
	texture.load(path)
	index = id - 1
