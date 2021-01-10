extends ColorRect
class_name Map

var g_color:Color = Color(0,0,1)
var p_color:Color = Color(1,0,0)
var h_color:Color = Color(1,0,1)
var t_color:Color = Color(0,1,0)
var f_color:Color = Color(1,1,1)

var rad:float = 10.0
var midPoint:Vector2 = Vector2()
var factor:float = 1.0

var gifts:Spatial
var houses:Spatial 
var trees:Spatial
var player:Vector2 = Vector2()
var dynamic_font = DynamicFont.new()

var rotation:float = 0;

const MidPlace:Vector2 = Vector2(-186.5, -126.5)

func _ready():
	midPoint = Vector2(get_rect().size.x / 2, get_rect().size.y / 2)
	
	dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://assets/Fonts/atwriter.ttf")
	dynamic_font.size = 20


func _process(delta):
	update()
	midPoint = Vector2(get_rect().size.x / 2, get_rect().size.y / 2)
	factor = get_rect().size.x / 400

func _draw():	
	draw_circle(Vector2(100,100), 20, g_color)
	draw_string(dynamic_font, Vector2(125,105), "gift (" + str(gifts.get_child_count()) + ")")
	
	draw_circle(Vector2(100,140), 20, p_color)
	draw_string(dynamic_font, Vector2(125,145), "player")
	
	draw_circle(Vector2(100,180), 20, t_color)
	draw_string(dynamic_font, Vector2(125,185), "tree")
	
	draw_circle(Vector2(100,220), 20, h_color)
	draw_string(dynamic_font, Vector2(125,225), "house")
	
	draw_set_transform(midPoint, rotation, Vector2(1,1))
	
	for x in range(0, gifts.get_child_count()):
		var gift:Spatial = gifts.get_child(x)
		var pos:=(Vector2(gift.translation.x, gift.translation.z) + MidPlace) * factor
		draw_circle(pos, rad, g_color)
		draw_string(dynamic_font, pos, str(x), f_color)
	
		
	for x in range(0, houses.get_child_count()):
		var house:Spatial = houses.get_child(x)
		draw_circle((Vector2(house.translation.x, house.translation.z) + MidPlace) * factor, rad, h_color)
		
	for x in range(0, trees.get_child_count()):
		var tree:Spatial = trees.get_child(x)
		draw_circle((Vector2(tree.translation.x, tree.translation.z) + MidPlace) * factor, rad, t_color)
#
#	for x in houses:
#		draw_circle((houses[x] + MidPlace) * factor, rad, h_color)
#
#	for x in trees:
#		draw_circle((trees[x] + MidPlace) * factor, rad, t_color)
		
	draw_circle((player + MidPlace) * factor, rad, p_color)
