extends Spatial

var UP:Vector3 = Vector3(0,1,0) #Camera UP direction
var Look:Vector3 = Vector3() 	#Camera Look direction
var Left:Vector3 = Vector3() 	#Camera Left direction

var velocity:Vector3 = Vector3() 	#Player Overall Velocity
var velocityg:Vector3 = Vector3() 	#Player Velocity due to gravity

var frameTime	:float = 0.0	#Time since last frame
var gravity_accl:float = 9.81	#Gravitational Acceleration

var onHit	:bool = false	#If the screen is on hit or the Move Controller

onready var player		:Player 		= $player		#the player root
onready var animations	:OptionButton 	= $UI/Options	#animation List

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
			player.set_idle_id(count)
		
		count+=1
		
	for x in ["Hand", "Pistol", "Rifle"]:
		$UI/Weapon.add_item(x)
		
	player.set_weapon(0)

func _process(delta):	
	frameTime = delta
	player.update(delta)
	
	velocityg.y -= gravity_accl * delta
	
	if player.is_on_floor():
		velocityg.y = abs(velocityg.y) * sqrt(0)
		if abs(velocityg.y) < 0.1: velocityg *= 0
	
	velocity = player.move_and_slide(velocityg,UP)

var index:int = -1

func _input(event):
	if onHit and event is InputEventScreenDrag:
		player.update_rotate(event.relative)
	if event is InputEventScreenTouch:
		onHit = true

func _on_MoveController_Move(speedFront, speedLeft):
	player.set_move(speedFront, speedLeft)

func _on_MoveController_onHit():
	onHit = false

func _on_MoveController_run(run):
	player.set_run(run)

func _on_idle_pressed():
	player.set_idle_id(animations.get_selected_id())

func _on_walk_pressed():
	player.set_walk_id(animations.get_selected_id())

func _on_run_pressed():
	player.set_run_id(animations.get_selected_id())

func _on_list_pressed():
	print_debug("Idle : " + str(player.idle_id) + " Walk : " + str(player.walk_id) + " Run : " + str(player.run_id) + " Fire : " + str(player.fire_id))

func _on_fire_pressed():
	player.set_fire_id(animations.get_selected_id())

func _on_Weapon_item_selected(index):
	player.set_weapon(index)

func _on_fireWeapon_button_down():
	player.fireIt(true)
