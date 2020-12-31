extends Player
class_name Boy1, "res://src/Player/boy1.gd"

onready var animPlayer:AnimationPlayer = $AnimationPlayer

var run:bool = false

var UP:Vector3 = Vector3(0,1,0) #Camera UP direction
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
var mouse_sens	:float = 0.25					#Mouse sensitivity
var frameTime	:float = 0.0					#Time since last frame

onready var player			:Player 		= $"."			#the player root
onready var playerCharacter :KinematicBody 	= $Boy		#the player Character
onready var camera			:Camera			= $Camera

func set_run(run:bool):
	player.run = run

func init():
	rot = camera.rotation
	
	trackerDirBase = camera.translation
	trackerTranslation.y = trackerDirBase.y
	trackerDirBase -= trackerTranslation
	trackerDist = trackerDirBase.length()
	
	trackerDirBase = trackerDirBase.normalized()
	trackerDir = trackerDirBase

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
		playerCharacter.rotation.y = camera.rotation.y + atan2(move_dir.z,-move_dir.x) - PI/2;
	
	velocityp = velocityp * 0
	
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
	
	camera.translation = playerCharacter.translation
	camera.translation += trackerTranslation.y * UP
	camera.translation += trackerDir * trackerDist

func update_rotate(dir:Vector2):
	rot.y += -dir.x * mouse_sens * frameTime
	rot.x += -dir.y * mouse_sens * frameTime
	rot.x = -min(max(-rot.x,-PI/8),PI/2)
	camera.rotation = rot

func set_move(speedFront, speedLeft):
	move_dir.x = speedLeft;  move_dir.z = speedFront
	if move_dir.length() > 0.1:
		move_dir = move_dir.normalized() * max(move_dir.length(), 0.7)
		
func loadAnimationList() -> PoolStringArray:
	_loadAnimationList($AnimationPlayer)
	return AnimationList

func is_on_floor() -> bool:
	return playerCharacter.is_on_floor()
	
func move_and_slide(velocityg:Vector3, UP:Vector3) -> Vector3:
	return playerCharacter.move_and_slide(velocityg,UP)
	
func animate_id(id:int, forward:bool = true):
	var name:String = AnimationList[id]
	play_animation(name)

func animate(name:String, forward:bool = true):
	play_animation(name)

func _walk():
	if walk_id >= 0:
		animate_id(walk_id)
	else:
		play_animation(Player.Walk, true, sqrt(abs(move_dir.length())))

	velocityp = move_dir.x * Left * PLAYER_WALK
	velocityp += move_dir.z * Look * PLAYER_WALK

func _run():
	if run_id >= 0:
		animate_id(run_id)
	else:
		play_animation(Player.Run, true, sqrt(abs(move_dir.length())))
	
	velocityp = move_dir.x * Left * PLAYER_RUN
	velocityp += move_dir.z * Look * PLAYER_RUN

func get_animation(x:String) -> Animation:
	return animPlayer.get_animation(x)

func play_animation_id(id:int, forward:bool = true, speed:float = 1.0):
	animPlayer.set_speed_scale(speed)
	
	animate_id(id, forward)

func play_animation(name:String, forward:bool = true, speed:float = 1.0):
	animPlayer.set_speed_scale(speed)
	
	if not animPlayer.get_current_animation() == name:
		if forward:
			animPlayer.play(name)
		else:
			animPlayer.play_backwards(name)
	else:
		if forward:
			if backward:
				animPlayer.play(name)
		else:
			if not backward:
				animPlayer.play_backwards(name)
	backward = not forward
