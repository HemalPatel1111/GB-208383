extends Spatial
class_name Player, "res://src/Player/Player.gd"

const Walk = "Standard Walking in place"
const Run = "Standard Running in place"
const IdleBreath = "Standard Breathing Idle"

var backward:bool = false
var cur_anim:String
var AnimationList:PoolStringArray
var loop:bool = false

# Loads Animation list
func loadAnimationList() -> PoolStringArray:
	return PoolStringArray()

func move_and_slide(vel:Vector3, up:Vector3) -> Vector3:
	return vel

func set_move_dir(speedFront:float, speedLeft:float):
	pass

func update_rotation(dir:Vector2, mouse_sens:float, frameTime:float):
	pass

func init():
	pass

func update(delta, Look:Vector3, Left:Vector3, UP:Vector3, id:int):
	pass

func is_on_floor()->bool:
	return false

# Animates the character
func animate(x:int):
	pass

# make the character walking
func walk(move_dir:Vector3):
	pass
# plays a particular animation

func play_animation(name:String, forward:bool = true, speed:float = 1.0):
	pass
# gets a particular animation

func get_animation(x:String) -> Animation:
	return null
# generates the Animation List

#---------------- Protected Function -------------------------------

func _loadAnimationList(animPlayer:AnimationPlayer):
	AnimationList = $AnimationPlayer.get_animation_list()
