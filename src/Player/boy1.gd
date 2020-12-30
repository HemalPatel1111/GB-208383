extends Player
class_name Boy1, "res://src/Player/boy1.gd"

onready var animPlayer:AnimationPlayer = $AnimationPlayer

func loadAnimationList() -> PoolStringArray:
	_loadAnimationList($AnimationPlayer)
	return AnimationList
	
func animate(x:int):
	var name:String = AnimationList[x]
	play_animation(name)
	
func walk(move_dir:Vector3):
	pass
	
func get_animation(x:String) -> Animation:
	return animPlayer.get_animation(x)
	
func play_animation(name:String, forward:bool = true, speed:float = 1.0):
	animPlayer.set_speed_scale(speed)
	
	if not animPlayer.get_current_animation() == name:
		if forward:
			animPlayer.play(name)
		else:
			animPlayer.play_backwards(name)
	else:
		if forward:
			if backward:
				animPlayer.play(name)
		else:
			if not backward:
				animPlayer.play_backwards(name)
	backward = not forward
