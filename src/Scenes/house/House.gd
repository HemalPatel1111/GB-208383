extends Spatial



func _on_body_entered(body:KinematicBody):
	if body.name == "Boy" or body.name == "Girl" :
		var player:Player = body.get_parent()
		player.down_health(3)
