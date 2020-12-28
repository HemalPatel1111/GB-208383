extends Spatial
class_name Player

var Prone:bool = false

func Prone():
	if Prone:
		$AnimationPlayer.play_backwards("walking")
	else:
		$AnimationPlayer.play("walking")
		
	Prone = not Prone
