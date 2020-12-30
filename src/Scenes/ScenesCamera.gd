extends Spatial

var UP:Vector3 = Vector3(0,1,0) #UP direction

var PLAYER_SCALE:float = 0.2 #describes how much scalled the player is
var PLAYER_WALK:float = 2.5417 * PLAYER_SCALE #describes how long a player can walk per walk animation

var mouse_sens = 0.05
var rot:Vector3 = Vector3()

var Look:Vector3 = Vector3()
var Left:Vector3 = Vector3()

var frameTime:float = 0.0

var velocity:Vector3 = Vector3()
var velocityg:Vector3 = Vector3()
var velocityp:Vector3 = Vector3()

var trackerPos:Vector3 = Vector3()
var gravity_accl:float = 9.81

onready var player:Player = $player
onready var playerCharacter:KinematicBody = $player/Boy
onready var tracker:Spatial = $player/tracker
onready var options:OptionButton = $UI/Options

var onHit:bool = false
var move_dir:Vector2 = Vector2()

func _ready():
	rot = tracker.rotation * 180
	player.loadAnimation()
	
	var list = player.AnimationList
	var count:int = 0
	
	for x in list:
		var anim:Animation =  $boy1/AnimationPlayer.get_animation(x)
		var check:bool = false
		
		if x == Player.IdleBreath:
			check = true
		
		if anim.has_loop() :
			x = "L " + x
		options.add_item(x)
		if check:
			options._select_int(count)
		count+=1
		
	trackerPos = tracker.translation
	
func _process(delta):
	frameTime = delta	
	rot = tracker.rotation * 180
	
	Look = global_transform.basis.z
	Left = global_transform.basis.x
	Look = Look.rotated(global_transform.basis.y, rot.y / 180)
	Left = Left.rotated(global_transform.basis.y, rot.y / 180)
	
	if move_dir.length() > 0.1:
		playerCharacter.rotation.y = PI/2 + atan2(move_dir.y,-move_dir.x);
	
	velocityp = velocityp * 0
	
	if move_dir.length() > 0.1:
		player.play_animation(Player.Walk, true, sqrt(abs(move_dir.length())))
		velocityp = move_dir.x * Left * PLAYER_WALK
		velocityp += move_dir.y * Look * PLAYER_WALK
	else:
		player.animate(options.get_selected_id())
	
	velocityg.y -= gravity_accl * delta
	
	if playerCharacter.is_on_floor():
		velocityg.y = abs(velocityg.y) * sqrt(0.1)
	
	velocity = playerCharacter.move_and_slide(velocityg + velocityp,UP)
	
	tracker.translation = playerCharacter.translation
	tracker.translation += -trackerPos.z * Look
	tracker.translation += trackerPos.y * UP
	tracker.translation += trackerPos.x * Left

func _input(event):
	if onHit and event is InputEventMouseMotion:
		rot.y += -event.relative.x * mouse_sens * frameTime * 500
		rot.x += -event.relative.y * mouse_sens * frameTime * 500
		rot.x = min(max(rot.x,-90),90)
		tracker.rotation = rot / 180
		
	if event is InputEventMouseButton:
		onHit = (event.button_mask == 1)

func _on_MoveController_Move(speedFront, speedLeft):
	move_dir.x = speedLeft;  move_dir.y = speedFront

func _on_MoveController_onHit():
	onHit = false

func _on_Button_pressed():
	player.animate(options.get_selected_id())
