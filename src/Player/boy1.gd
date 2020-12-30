extends Player
class_name Boy1, "res://src/Player/boy1.gd"

onready var animPlayer:AnimationPlayer = $AnimationPlayer


const  PLAYER_SCALE:float = 0.2 					#Scalling of the player
const  PLAYER_WALK	:float = 2.4642 * PLAYER_SCALE #player walk length per walk animation
const  PLAYER_RUN	:float = 9.1094 * PLAYER_SCALE #player run length per walk animation


var rot:Vector3 = Vector3() 	#Camera Target rotation
var velocityp:Vector3 = Vector3() 	#Player Velocity frm Move Controller

var trackerTranslation:Vector3 = Vector3() 	#Position of player Camera
var trackerDirBase:Vector3 = Vector3() 	#Position of player Camera
var trackerDir:Vector3 = Vector3() 	#Position of player Camera 
var trackerDist:float = 10.0

var move_dir:Vector3 = Vector3()	#direction of movement of player
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

func update(delta, Look:Vector3, Left:Vector3, UP:Vector3, id:int):
	rot = camera.rotation
	
	Look = Look.rotated(global_transform.basis.y, rot.y)
	Left = Left.rotated(global_transform.basis.y, rot.y)
	
	trackerDir = trackerDirBase.rotated(UP, rot.y)
	trackerDir = -trackerDir.rotated(Left, rot.x)
	
	if move_dir.length() > 0.1:
		playerCharacter.rotation.y = camera.rotation.y + atan2(move_dir.z,-move_dir.x) - PI/2;
	
	velocityp = velocityp * 0
	
	if move_dir.length() > 0.1:
		player.play_animation(Player.Run, true, sqrt(abs(move_dir.length())))
		velocityp = move_dir.x * Left * PLAYER_RUN
		velocityp += move_dir.z * Look * PLAYER_RUN
	else:
		player.animate(id)
	
	camera.translation = playerCharacter.translation
	camera.translation += trackerTranslation.y * UP
	camera.translation += trackerDir * trackerDist

func update_rotation(dir:Vector2, mouse_sens:float, frameTime:float):
	rot.y += dir.x * mouse_sens * frameTime
	rot.x += dir.y * mouse_sens * frameTime
	rot.x = min(max(rot.x,-PI/8),PI/2)
	camera.rotation = rot

func set_move_dir(speedFront:float, speedLeft:float):
	move_dir.x = speedLeft;  move_dir.z = speedFront
	if move_dir.length() > 0.1:
		move_dir = move_dir.normalized() * max(move_dir.length(), 0.7)

func loadAnimationList() -> PoolStringArray:
	_loadAnimationList($AnimationPlayer)
	return AnimationList
	
func animate(x:int):
	var name:String = AnimationList[x]
	play_animation(name)

func move_and_slide(vel:Vector3, up:Vector3) -> Vector3:
	return playerCharacter.move_and_slide(vel + velocityp, up)

func is_on_floor()->bool:
	return playerCharacter.is_on_floor()
	
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
