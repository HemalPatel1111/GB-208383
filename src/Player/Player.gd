extends Spatial
class_name Player, "res://src/Player/Player.gd"

const Walk = "Standard Walking in place"
const IdleBreath = "Standard Breathing Idle"

var backward:bool = false
var cur_anim:String
var AnimationList:PoolStringArray
var loop:bool = false

func init():
	pass

func update(delta):
	pass

func set_move(speedFront, speedLeft):
	pass

# Loads Animation list
func loadAnimationList() -> PoolStringArray:
	return PoolStringArray()
	
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
