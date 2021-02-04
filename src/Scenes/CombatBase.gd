extends Spatial


onready var moveController :MoveControllerTS = $UI/MoveController #player movement controller
onready var weaponSelector :WeaponSelector   = $UI/WeaponSelector #player movement controller
onready var fireWeapon	   :FireWeapon 		 = $UI/fireWeapon #Fire-weapon button
onready var healthBar      :Control   = $UI/HealthBar #player movement controller
onready var player		   :Player 			 = $player #the player root
var velocity:  Vector3 = Vector3() #Player Overall Velocity
var velocityg: Vector3 = Vector3() #Player Velocity due to gravity
var frameTime	 :float  = 0.0  #Time since last frame
export var gravity :float = 9.81 #Gravitational Acceleration

func _ready():
	player.init()

	fireWeapon.set_Player(player)
	moveController.set_Player(player)
	weaponSelector.set_Player(player)
	player.set_weapon(Weapon.HAND)

func _process(delta):	
	frameTime = delta
	player.update(delta)
	
	velocityg.y -= gravity * delta
	
	if player.is_on_floor():
		velocityg.y = abs(velocityg.y) * sqrt(0)
		if abs(velocityg.y) < 0.1: velocityg *= 0
	
	velocity = player.move_and_slide(velocityg, GiftData.UP)
	healthBar.value = player.get_health()
	
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
