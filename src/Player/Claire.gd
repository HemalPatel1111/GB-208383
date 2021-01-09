extends Player

func init():
	if not loaded:
		_animPlayer = $AnimationPlayer
		_player = $"."
		playerCharacter = $Girl
		_camera = $Camera
		loaded = true
		
		rot = _camera.rotation
		
		trackerDirBase = _camera.translation
		trackerTranslation.y = trackerDirBase.y
		trackerDirBase -= trackerTranslation
		trackerDist = trackerDirBase.length()
		
		trackerDirBase = trackerDirBase.normalized()
		trackerDir = trackerDirBase
		
		PLAYER_SCALE = scale.x
		
		PLAYER_WALK = 1.11668
		PLAYER_RUN = 2.48100
		PLAYER_WALK_PISTOL = 1.77258
		PLAYER_RUN_PISTOL = 3.21874
		PLAYER_WALK_RIFLE = 1.29117
		PLAYER_RUN_RIFLE = 3.12801

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
