extends Spatial
class_name Player, "res://src/Player/Player.gd"

const Walk = "Standard Walking in place"
const Run = "Standard Running in place"
const IdleBreath = "Standard Breathing Idle"

var idle_id:int = -1
var walk_id:int = -1
var run_id:int = -1
var fire_id:int = -1

var fire:bool = false

var backward:bool = false
var cur_anim:String
var AnimationList:PoolStringArray
var loop:bool = false

func set_idle_id(id:int):
	idle_id = id
	
func set_walk_id(id:int):
	walk_id = id
	
func set_run_id(id:int):
	run_id = id
	
func set_fire_id(id:int):
	fire_id = id

func set_weapon(weapon_id:int):
	pass

func fireIt(value:bool):
	fire = value
	pass

func move_and_slide(velocityg:Vector3, UP:Vector3) -> Vector3:
	return Vector3()

func is_on_floor() -> bool:
	return false

func init():
	pass

func set_run(run:bool):
	pass

func update(delta):
	pass

func update_rotate(dir:Vector2):
	pass

func set_move(speedFront, speedLeft):
	pass
# Loads Animation list
func loadAnimationList() -> PoolStringArray:
	return PoolStringArray()
	
# Animates the character
func animate_id(id:int, forward:bool = true):
	pass
	
func animate(name:String, forward:bool = true):
	pass

# plays a particular animation
func play_animation_id(id:int, forward:bool = true, speed:float = 1.0):
	pass

func play_animation(name:String, forward:bool = true, speed:float = 1.0):
	pass
# gets a particular animation

func get_animation(x:String) -> Animation:
	return null
# generates the Animation List

#---------------- Protected Function -------------------------------

func _loadAnimationList(animPlayer:AnimationPlayer):
	AnimationList = animPlayer.get_animation_list()
