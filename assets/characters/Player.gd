extends Spatial
class_name Player

var animation:bool = false
var cur_anim:String

func animate(x:String):	
	if(cur_anim != x):
		animation = false;
	
	cur_anim = x
	
	if animation:
		$AnimationPlayer.play_backwards(cur_anim)
	else:
		$AnimationPlayer.play(cur_anim)
		
	animation = not animation
