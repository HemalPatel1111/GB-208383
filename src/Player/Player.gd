extends Spatial
class_name Player, "res://src/Player/Player.gd"

const Walk = "Standard Walking in place"
const Run = "Standard Running in place"
const IdleBreath = "Standard Breathing Idle"

var idle_id:int = -1
var walk_id:int = -1
var run_id:int = -1
var fire_id:int = -1

var fire:bool = false

var backward:bool = false
var cur_anim:String
var AnimationList:PoolStringArray
var loop:bool = false

var loaded:bool = false

var run:bool = false

var UP:Vector3 = Vector3(0,1,0) #_camera UP direction
var Look:Vector3 = Vector3() 	#Camera Look direction
var Left:Vector3 = Vector3() 	#Camera Left direction

var rot:Vector3 = Vector3() 	#Camera Target rotation

var velocityp:Vector3 = Vector3() 	#Player Velocity frm Move Controller

var trackerTranslation:Vector3 = Vector3() 	#Position of player Camera
var trackerDirBase:Vector3 = Vector3() 	#Position of player Camera
var trackerDir:Vector3 = Vector3() 	#Position of player Camera 
var trackerDist:float = 10.0

var move_dir:Vector3 = Vector3()	#direction of movement of player

var PLAYER_SCALE:float = 0.2 					#Scalling of the player
var PLAYER_WALK	:float = 2.4642 * PLAYER_SCALE #player walk length per walk animation
var PLAYER_RUN	:float = 9.1094 * PLAYER_SCALE #player walk length per walk animation
var PLAYER_WALK_PISTOL:float = 4.1693 * PLAYER_SCALE
var PLAYER_RUN_PISTOL:float = 4.9035 * PLAYER_SCALE
var PLAYER_WALK_RIFLE:float = 1.5812 * PLAYER_SCALE
var PLAYER_RUN_RIFLE:float = 4.9166 * PLAYER_SCALE

var player_walk:float = PLAYER_WALK
var player_run:float = PLAYER_RUN

export var mouse_sens			:float = 0.01					#Mouse sensitivity
export var rotation_multiplier	:float = 25.0
var frameTime	:float = 0.0					#Time since last frame

var _animPlayer:AnimationPlayer
var _player			:Player			#the player root
var playerCharacter :KinematicBody	#the player Character
var _camera			:Camera			

func set_run(running:bool):
	run = running

func set_idle_id(id:int):
	idle_id = id
	
func set_walk_id(id:int):
	walk_id = id
	
func set_run_id(id:int):
	run_id = id
	
func set_fire_id(id:int):
	fire_id = id

func init():
	pass
	
func set_weapon(weapon:int):
	pass

func update(delta):
	frameTime = delta
	#rot = camera.rotation
	
	Look = Vector3(0,0,1)
	UP = Vector3(0,1,0)
	Left = Vector3(1,0,0)
	
	Look = Look.rotated(UP, rot.y)
	Left = Left.rotated(UP, rot.y)
	
	trackerDir = trackerDirBase.rotated(UP, rot.y)
	trackerDir = -trackerDir.rotated(Left, rot.x)
	
	if move_dir.length() > 0.1:
		playerCharacter.rotation.y = _camera.rotation.y + atan2(move_dir.z,-move_dir.x) - PI/2;
	
	velocityp = velocityp * 0
	
	if fire:
		_fire()
	else:
		if move_dir.length() > 0.1:
				if run:
					_run()
				else:
					_walk()
		else:
			if idle_id >= 0:
				animate_id(idle_id)
			else:
				animate(IdleBreath)
	
	velocityp = playerCharacter.move_and_slide(velocityp,UP)
	
	_camera.translation = playerCharacter.translation
	_camera.translation += trackerTranslation.y * UP
	_camera.translation += trackerDir * trackerDist

func update_rotate(dir:Vector2):
	rot.y += -dir.x * mouse_sens * frameTime * rotation_multiplier
	rot.x += -dir.y * mouse_sens * frameTime * rotation_multiplier
	rot.x = -min(max(-rot.x,-PI/8),PI/2)
	_camera.rotation = rot

func set_move(speedFront, speedLeft):
	move_dir.x = speedLeft;  move_dir.z = speedFront
	if move_dir.length() > 0.1:
		move_dir = move_dir.normalized() * max(move_dir.length(), 0.7)
		
func loadAnimationList() -> PoolStringArray:
	_loadAnimationList(_animPlayer)
	return AnimationList

func is_on_floor() -> bool:
	return playerCharacter.is_on_floor()
	
func move_and_slide(velocityg:Vector3, _Up:Vector3) -> Vector3:
	return playerCharacter.move_and_slide(velocityg,_Up)
	
func animate_id(id:int, forward:bool = true):
	var name:String = AnimationList[id]
	play_animation(name, forward)

func animate(name:String, forward:bool = true):
	play_animation(name, forward)

func _fire():
	if fire_id >= 0 : animate_id(fire_id)

func _walk():
	if walk_id >= 0:
		animate_id(walk_id)
	else:
		play_animation(Walk, true, sqrt(abs(move_dir.length())))

	velocityp = move_dir.x * Left * player_walk
	velocityp += move_dir.z * Look * player_walk

func _run():
	if run_id >= 0:
		animate_id(run_id)
	else:
		play_animation(Run, true, sqrt(abs(move_dir.length())))
	
	velocityp = move_dir.x * Left * player_run
	velocityp += move_dir.z * Look * player_run

func get_animation(x:String) -> Animation:
	return _animPlayer.get_animation(x)

func play_animation_id(id:int, forward:bool = true, speed:float = 1.0):
	_animPlayer.set_speed_scale(speed)
	
	animate_id(id, forward)

func play_animation(name:String, forward:bool = true, speed:float = 1.0):
	_animPlayer.set_speed_scale(speed)
	
	if not _animPlayer.get_current_animation() == name:
		if forward:
			_animPlayer.play(name)
		else:
			_animPlayer.play_backwards(name)
	else:
		if forward:
			if backward:
				_animPlayer.play(name)
		else:
			if not backward:
				_animPlayer.play_backwards(name)
	backward = not forward


func _on_AnimationPlayer_animation_finished(anim_name):
	fireIt(false)


func fireIt(value:bool):
	fire = value

#---------------- Protected Function -------------------------------

func _loadAnimationList(_animPlayer:AnimationPlayer):
	AnimationList = _animPlayer.get_animation_list()
