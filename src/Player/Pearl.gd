extends Player

func init():
	if not loaded:
		_animPlayer = $AnimationPlayer
		_player = $"."
		playerCharacter = $Girl
		_camera = $Camera
		loaded = true
		
		loadAnimationList()
		
		rot = _camera.rotation
		
		trackerDirBase = _camera.translation
		trackerTranslation.y = trackerDirBase.y
		trackerDirBase -= trackerTranslation
		trackerDist = trackerDirBase.length()
		
		trackerDirBase = trackerDirBase.normalized()
		trackerDir = trackerDirBase
		
		PLAYER_SCALE = scale.x
		
		PLAYER_WALK = 1.30292
		PLAYER_RUN = 2.89476
		PLAYER_WALK_PISTOL = 2.06819
		PLAYER_RUN_PISTOL = 3.75551
		PLAYER_WALK_RIFLE = 1.50649
		PLAYER_RUN_RIFLE = 3.64966

func set_weapon(weapon:int):
	match weapon:
		Weapon.HAND:
			idle_id = 0; walk_id = 20; run_id = 19; fire_id = 9
			player_walk = PLAYER_WALK
			player_run = PLAYER_RUN
		Weapon.PISTOL:
			idle_id = 3; walk_id = 7; run_id = 6; fire_id = 2
			player_walk = PLAYER_WALK_PISTOL
			player_run = PLAYER_RUN_PISTOL
		Weapon.RIFLE:
			idle_id = 10; walk_id = 18; run_id = 17; fire_id = 12
			player_walk = PLAYER_WALK_RIFLE
			player_run = PLAYER_RUN_RIFLE
