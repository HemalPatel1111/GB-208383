extends Spatial

const  mouse_sens	:float = 0.15					#Mouse sensitivity
const  gravity_accl:float = 9.81					#Gravitational Acceleration

var UP:Vector3 = Vector3(0,1,0) #Camera UP direction
var Look:Vector3 = Vector3() 	#Camera Look direction
var Left:Vector3 = Vector3() 	#Camera Left direction

onready var player			:Player 		= $player			#the player root

var velocity:Vector3 = Vector3() 	#Player Overall Velocity
var velocityg:Vector3 = Vector3() 	#Player Velocity due to gravity

var frameTime	:float = 0.0					#Time since last frame

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
