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
		
		PLAYER_SCALE = scale.x
		#			hand	Pistol		Rifle
		#walk 	: 1.11668
		#run 	: 1.81858

func set_weapon(weapon:int):
	match weapon:
		Weapon.HAND:
			idle_id = 0 ; walk_id = 21; run_id = 20; fire_id = 9
			player_walk = PLAYER_WALK
			player_run = PLAYER_RUN
		Weapon.PISTOL:
			idle_id = 3; walk_id = 8; run_id = 6; fire_id = 2
			player_walk = PLAYER_WALK_PISTOL
			player_run = PLAYER_RUN_PISTOL
		Weapon.RIFLE:
			idle_id = 12; walk_id = 19; run_id = 18; fire_id = 14
			player_walk = PLAYER_WALK_RIFLE
			player_run = PLAYER_RUN_RIFLE
