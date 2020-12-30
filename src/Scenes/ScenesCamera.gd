extends Spatial

var UP:Vector3 = Vector3(0,1,0) #Camera UP direction
var Look:Vector3 = Vector3() 	#Camera Look direction
var Left:Vector3 = Vector3() 	#Camera Left direction


var rot:Vector3 = Vector3() 	#Camera Target rotation

var velocity:Vector3 = Vector3() 	#Player Overall Velocity
var velocityg:Vector3 = Vector3() 	#Player Velocity due to gravity
var velocityp:Vector3 = Vector3() 	#Player Velocity frm Move Controller

var trackerTranslation:Vector3 = Vector3() 	#Position of player Camera
var trackerDirBase:Vector3 = Vector3() 	#Position of player Camera
var trackerDir:Vector3 = Vector3() 	#Position of player Camera 
var trackerDist:float = 10.0

var move_dir:Vector3 = Vector3()	#direction of movement of player

var frameTime	:float = 0.0					#Time since last frame
var PLAYER_SCALE:float = 0.2 					#Scalling of the player
var PLAYER_WALK	:float = 2.5417 * PLAYER_SCALE #player walk length per walk animation
var mouse_sens	:float = 0.15					#Mouse sensitivity
var gravity_accl:float = 9.81					#Gravitational Acceleration

var onHit	:bool = false	#If the screen is on hit or the Move Controller

onready var player			:Player 		= $player			#the player root
onready var playerCharacter :KinematicBody 	= $player/Boy		#the player Character
onready var animations		:OptionButton 	= $UI/Options	#animation List
onready var camera			:Camera			= $player/Camera

func _ready():	
	var list:PoolStringArray
	var count:int = 0
	
	rot = camera.rotation
	
	trackerDirBase = camera.translation
	trackerTranslation.y = trackerDirBase.y
	trackerDirBase -= trackerTranslation
	trackerDist = trackerDirBase.length()
	trackerDirBase = trackerDirBase.normalized()
	trackerDir = trackerDirBase
	
	list = player.loadAnimationList()
	
	for x in list:
		var anim:Animation =  player.get_animation(x)
		var check:bool = false
		
		if x == Player.IdleBreath:
			check = true
		
		if anim.has_loop() :
			x = "L " + x
		
		animations.add_item(x)
		
		if check:
			animations._select_int(count)
		
		count+=1
		
	
func _process(delta):	
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
		player.play_animation(Player.Walk, true, sqrt(abs(move_dir.length())))
		velocityp = move_dir.x * Left * PLAYER_WALK
		velocityp += move_dir.z * Look * PLAYER_WALK
	else:
		player.animate(animations.get_selected_id())
	
	velocityg.y -= gravity_accl * delta
	
	if playerCharacter.is_on_floor():
		velocityg.y = abs(velocityg.y) * sqrt(0)
		if abs(velocityg.y) < 0.1: velocityg *= 0
	
	velocity = playerCharacter.move_and_slide(velocityg + velocityp,UP)
	
	camera.translation = playerCharacter.translation
	camera.translation += trackerTranslation.y * UP
	camera.translation += trackerDir * trackerDist

func _input(event):
	if onHit and event is InputEventMouseMotion:
		rot.y += -event.relative.x * mouse_sens * frameTime
		rot.x += -event.relative.y * mouse_sens * frameTime
		rot.x = -min(max(-rot.x,-PI/8),PI/2)
		camera.rotation = rot
		
	if event is InputEventMouseButton:
		onHit = (event.button_mask == 1)

func _on_MoveController_Move(speedFront, speedLeft):
	move_dir.x = speedLeft;  move_dir.z = speedFront

func _on_MoveController_onHit():
	onHit = false

func _on_Button_pressed():
	player.animate(animations.get_selected_id())
