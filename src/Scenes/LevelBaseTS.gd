extends Spatial
class_name LevelBase

var UP:  Vector3 = Vector3(0,1,0) #Camera UP direction
var Look:Vector3 = Vector3()	 #Camera Look direction
var Left:Vector3 = Vector3()	 #Camera Left direction

var velocity:  Vector3 = Vector3() #Player Overall Velocity
var velocityg: Vector3 = Vector3() #Player Velocity due to gravity

var frameTime	 :float  = 0.0  #Time since last frame

#Level specific
var gifts_target:PoolIntArray = PoolIntArray()
var gifts_type:PoolIntArray = PoolIntArray()
#Runtime
var gifts_picked:PoolIntArray = PoolIntArray()

export var gravity :float = 9.81 #Gravitational Acceleration

onready var player		   :Player 			 = $player #the player root
onready var animations	   :OptionButton 	 = $UI/Options #animation List
onready var fireWeapon	   :FireWeapon 		 = $UI/fireWeapon #Fire-weapon button
onready var moveController :MoveControllerTS = $UI/MoveController #player movement controller
onready var weaponSelector :WeaponSelector   = $UI/WeaponSelector #player movement controller
onready var pickButton     :PickButton       = $UI/PickButton #player movement controller

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
		
	fireWeapon.set_Player(player)
	moveController.set_Player(player)
	weaponSelector.set_Player(player)
	pickButton.set_Player(player)
	
	GiftData.set_pick_button(pickButton)
	
	player.set_weapon(Weapon.HAND)
	

func _process(delta):	
	frameTime = delta
	player.update(delta)
	
	velocityg.y -= gravity * delta
	
	if player.is_on_floor():
		velocityg.y = abs(velocityg.y) * sqrt(0)
		if abs(velocityg.y) < 0.1: velocityg *= 0
	
	velocity = player.move_and_slide(velocityg,UP)

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

func _input(event):
	if not (event is InputEventScreenTouch or event is InputEventScreenDrag):
		return

	if event is InputEventScreenDrag:
		var check:bool = false
		check = moveController.index != (event.index)
		check = check and fireWeapon.index != (event.index)
		check = check and weaponSelector.index != (event.index)
		
		if check:
			player.update_rotate(event.relative)
	pass

func _can_grab_gift() -> bool:
	return gifts_picked.size() <= 3

func _on_gift_picked(gift_index):
	gifts_picked.append(gift_index)
	
func _on_gift_delivered(gift_index):
	gifts_picked.remove(gift_index)
