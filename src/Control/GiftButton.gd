extends Control
class_name GiftButton

var index:= -1
var texture:=StreamTexture.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	update()

func load_gift(id:int, type_id:int):
	GiftData.load_data()
	var path:String= GiftData.gifts_icons[type_id]
	texture = load(path)
	index = id - 1
#	$Icon.set_stretch_mode(5)
#	$Icon.set_expand(true)
	$Icon.set_normal_texture(texture)
	$Label.text = "Gift " + str(index + 1)

func _on_Label_ready():
	pass
func _on_Icon_ready():
	pass
