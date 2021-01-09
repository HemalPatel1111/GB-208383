extends Player

func init():
	if not loaded:
		_animPlayer = $AnimationPlayer
		_player = $"."
		_playerCharacter = $Girl
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

func set_weapon(weapon:int):
	match weapon:
		Weapon.HAND:
			idle_id = 17; walk_id = 20; run_id = 19; fire_id = 7
			player_walk = PLAYER_WALK
			player_run = PLAYER_RUN
		Weapon.PISTOL:
			idle_id = 1; walk_id = 5; run_id = 4; fire_id = 0
			player_walk = PLAYER_WALK_PISTOL
			player_run = PLAYER_RUN_PISTOL
		Weapon.RIFLE:
			idle_id = 9; walk_id = 16; run_id = 15; fire_id = 11
			player_walk = PLAYER_WALK_RIFLE
			player_run = PLAYER_RUN_RIFLE
