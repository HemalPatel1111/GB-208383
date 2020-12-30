extends Player
class_name Boy1, "res://src/Player/boy1.gd"

onready var animPlayer:AnimationPlayer = $AnimationPlayer


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
var PLAYER_WALK	:float = 2.5417 * PLAYER_SCALE #player walk length per walk animation
var mouse_sens	:float = 0.15					#Mouse sensitivity
var frameTime	:float = 0.0					#Time since last frame

onready var player			:Player 		= $"."			#the player root
onready var playerCharacter :KinematicBody 	= $Boy		#the player Character
onready var camera			:Camera			= $Camera


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
	rot = camera.rotation
	
	Look = global_transform.basis.z
	UP = global_transform.basis.y
	Left = global_transform.basis.x
	
	Look = Look.rotated(global_transform.basis.y, rot.y)
	Left = Left.rotated(global_transform.basis.y, rot.y)
	
	trackerDir = trackerDirBase.rotated(UP, rot.y)
	trackerDir = -trackerDir.rotated(Left, rot.x)
	
	if move_dir.length() > 0.1:
		playerCharacter.rotation.y = camera.rotation.y + atan2(move_dir.z,-move_dir.x) - PI/2;
	
	velocityp = velocityp * 0
	
	if move_dir.length() > 0.1:
		play_animation(Player.Walk, true, sqrt(abs(move_dir.length())))
		velocityp = move_dir.x * Left * PLAYER_WALK
		velocityp += move_dir.z * Look * PLAYER_WALK
	else:
		animate(1)
	
	velocityp = playerCharacter.move_and_slide(velocityp,UP)
	
	camera.translation = playerCharacter.translation
	camera.translation += trackerTranslation.y * UP
	camera.translation += trackerDir * trackerDist

































func loadAnimationList() -> PoolStringArray:
	_loadAnimationList($AnimationPlayer)
	return AnimationList
	
func animate(x:int):
	var name:String = AnimationList[x]
	play_animation(name)
	
func walk(move_dir:Vector3):
	pass

func get_animation(x:String) -> Animation:
	return animPlayer.get_animation(x)
	
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
