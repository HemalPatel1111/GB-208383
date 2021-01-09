extends Player

func init():
	if not loaded:
		_animPlayer = $AnimationPlayer
		_player = $"."
		playerCharacter = $Boy
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
		
		PLAYER_WALK = 1.26215
		PLAYER_RUN = 3.29797
		PLAYER_WALK_PISTOL = 2.05105
		PLAYER_RUN_PISTOL = 3.72442
		PLAYER_WALK_RIFLE = 1.49400
		PLAYER_RUN_RIFLE = 3.61939

func set_weapon(weapon:int):
	match weapon:
		Weapon.HAND:
			idle_id = 0 ; walk_id = 20; run_id = 19; fire_id = 8
			player_walk = PLAYER_WALK
			player_run = PLAYER_RUN
		Weapon.PISTOL:
			idle_id = 3; walk_id = 7; run_id = 6; fire_id = 2
			player_walk = PLAYER_WALK_PISTOL
			player_run = PLAYER_RUN_PISTOL
		Weapon.RIFLE:
			idle_id = 11; walk_id = 18; run_id = 17; fire_id = 13
			player_walk = PLAYER_WALK_RIFLE
			player_run = PLAYER_RUN_RIFLE
