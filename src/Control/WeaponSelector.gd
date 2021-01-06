extends Control
class_name WeaponSelector

var Icon:= ["res://assets/weapon/hand.png",
"res://assets/weapon/pistol.png",
"res://assets/weapon/rifle.png"]

var _player:Player = null
var weapon:int = Weapon.HAND
var texture:ImageTexture = ImageTexture.new()

onready var cen: = get_rect().size / 2
var rad := 70.0
export var color: = Color(0, 0, 1)

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

var xdir:= 1

func _ready():
	texture.load(Icon[weapon])

func _process(delta):
	update()
	
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
			if xdir > 0:
				if weapon < Weapon.RIFLE:
					weapon += 1
				else:
					weapon = Weapon.HAND
			elif xdir < 0:
				if weapon > Weapon.HAND:
					weapon -= 1
				else:
					weapon = Weapon.RIFLE
			
			_player.set_weapon(weapon)
			texture.load(Icon[weapon])
#			$Button.set_texture(texture)
	elif event is InputEventScreenDrag:
		var e:InputEventScreenDrag = event
		
		if index == e.index:
			if e.relative.x > 0:
				xdir = -1
			elif e.relative.x < 0:
				xdir = 1

func _draw():
		
	color.a = 0.5
	draw_circle(cen, 70, color)	
	draw_set_transform(Vector2(), 0, Vector2(0.33,0.33))
	draw_texture(texture, Vector2())
	
	draw_set_transform(-get_position(), 0, Vector2(1,1))
#	if index >= 0:
	color.a = 1
	draw_rect(get_rect(), color, false)

	pass
