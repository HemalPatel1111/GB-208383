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
	if(cur_anim != name):
		backward = false;
		loop = $AnimationPlayer.get_animation(name).has_loop()
	
	cur_anim = name
	
	if backward:
		if not loop:
			$AnimationPlayer.play_backwards(cur_anim)
		else:
			$AnimationPlayer.stop()
	else:
		$AnimationPlayer.play(cur_anim)
	backward = not backward
