extends Player

func init():
	if not loaded:
		_animPlayer = $AnimationPlayer
		_player = $"."
		_playerCharacter = $Boy
		_camera = $Camera
		loaded = true
		
		rot = _camera.rotation
		
		trackerDirBase = _camera.translation
		trackerTranslation.y = trackerDirBase.y
		trackerDirBase -= trackerTranslation
		trackerDist = trackerDirBase.length()
		
		trackerDirBase = trackerDirBase.normalized()
		trackerDir = trackerDirBase
		
		scale = Vector3(PLAYER_SCALE, PLAYER_SCALE, PLAYER_SCALE)
