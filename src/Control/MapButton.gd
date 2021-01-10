extends Control
class_name MapButton

var _map:Map = null

var show:= false
var index:= -1

func set_Map(map:Map):
	_map = map
	_map.factor = 1024 / 600

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
		elif _touch_ended(e):
			index = -1
			show = not show
			_map.visible = show

func setGifts(Gifts:Spatial):
	_map.gifts = Gifts

func setGiftTarget(target:PoolIntArray):
	_map.gift_target = target

func setTrees(Trees:Spatial):
	_map.trees = Trees

func setHouses(Houses:Spatial):
	_map.houses = Houses

func setZombies(Zombies:Spatial):
	_map.zombies = Zombies 

func setGhosts(Ghosts:Spatial):
	_map.ghosts = Ghosts 

func setMonsters(Monsters:Spatial):
	_map.monsters = Monsters 

func setPlayer(player: Player):
	_map.player = Vector2(player.translation.x + player.playerCharacter.translation.x / player.scale.x, player.translation.z + player.playerCharacter.translation.z  / player.scale.z)
	_map.rotation = player.rot.y
