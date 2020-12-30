extends Spatial

<<<<<<< HEAD:src/Scenes/LevelBase.gd
const  mouse_sens	:float = 0.15					#Mouse sensitivity
const  gravity_accl:float = 9.81					#Gravitational Acceleration

=======
>>>>>>> parent of b6d9c8e... Change in Animation Checked:src/Scenes/ScenesCamera.gd
var UP:Vector3 = Vector3(0,1,0) #Camera UP direction
var Look:Vector3 = Vector3() 	#Camera Look direction
var Left:Vector3 = Vector3() 	#Camera Left direction

<<<<<<< HEAD:src/Scenes/LevelBase.gd
onready var player			:Player 		= $player			#the player root
=======

var rot:Vector3 = Vector3() 	#Camera Target rotation
>>>>>>> parent of b6d9c8e... Change in Animation Checked:src/Scenes/ScenesCamera.gd

var velocity:Vector3 = Vector3() 	#Player Overall Velocity
var velocityg:Vector3 = Vector3() 	#Player Velocity due to gravity

<<<<<<< HEAD:src/Scenes/LevelBase.gd
var frameTime	:float = 0.0					#Time since last frame

=======
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

>>>>>>> parent of b6d9c8e... Change in Animation Checked:src/Scenes/ScenesCamera.gd
var onHit	:bool = false	#If the screen is on hit or the Move Controller


onready var animations		:OptionButton 	= $UI/Options	#animation List


func _ready():	
	var list:PoolStringArray
	var count:int = 0
	
	player.init()
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
	
	Look = global_transform.basis.z
	UP = global_transform.basis.y
	Left = global_transform.basis.x
	
<<<<<<< HEAD:src/Scenes/LevelBase.gd
=======
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
	
>>>>>>> parent of b6d9c8e... Change in Animation Checked:src/Scenes/ScenesCamera.gd
	velocityg.y -= gravity_accl * delta
	
	player.update(delta, Look, Left, UP, animations.get_selected_id())
	
	if player.is_on_floor():
		velocityg.y = abs(velocityg.y) * sqrt(0)
		if abs(velocityg.y) < 0.1: velocityg *= 0
	
	velocity = player.move_and_slide(velocityg,UP)
	

func _input(event):
	if onHit and event is InputEventMouseMotion:
		player.update_rotation(event.relative, mouse_sens, frameTime)
		
	if event is InputEventMouseButton:
		onHit = (event.button_mask == 1)

func _on_MoveController_Move(speedFront, speedLeft):
	player.set_move_dir(speedFront, speedLeft)

func _on_MoveController_onHit():
	onHit = false

func _on_Button_pressed():
	player.animate(animations.get_selected_id())
