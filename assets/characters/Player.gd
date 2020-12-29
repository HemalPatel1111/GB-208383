extends Spatial
class_name Player

var backward:bool = false
var cur_anim:String
var AnimationList:PoolStringArray
var loop:bool = false

func loadAnimation():
	AnimationList = $AnimationPlayer.get_animation_list()

func animate(x:int):
	var name:String = AnimationList[x]
	play_animation(name)

func play_animation(name:String, forward:bool = true, speed:float = 1.0):
	$AnimationPlayer.set_speed_scale(speed)
	
	if not $AnimationPlayer.get_current_animation() == name:
		if forward:
			$AnimationPlayer.play(name)
		else:
			$AnimationPlayer.play_backwards(name)
	else:
		if forward:
			if backward:
				$AnimationPlayer.play(name)
		else:
			if not backward:
				$AnimationPlayer.play_backwards(name)
	
	backward = not forward
