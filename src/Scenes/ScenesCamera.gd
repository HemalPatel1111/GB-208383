extends Spatial

var UP:Vector3 = Vector3(0,1,0)
var PLAYER_SCALE:float = 0.2 * 5
var PLAYER_WALK:float = 2.5417 * PLAYER_SCALE

var mouse_sens = 0.05
var rot:Vector3 = Vector3()

var Look:Vector3 = Vector3()
var Left:Vector3 = Vector3()

var _delta:float = 0.0

var velocity:Vector3 = Vector3()
var g:float = 9.81

onready var player:Player = $boy1
var onHit:bool = false

func _ready():
	rot = $boy1/tracker.rotation * 180
	player.loadAnimation()
	var list = player.AnimationList
	
	for x in list:
		var anim:Animation =  $boy1/AnimationPlayer.get_animation(x)
		if anim.has_loop() :
			x = "L " + x
		$UI/Options.add_item(x)
	
func _process(delta):
	_delta = delta
	
	rot = $boy1/tracker.rotation * 180
	velocity.y -= g * delta
	
	if $boy1/Boy.is_on_floor():
		velocity.y = abs(velocity.y) * sqrt(0.3)
		
	velocity = $boy1/Boy.move_and_slide(velocity,UP)

func _input(event):
	if onHit and event is InputEventMouseMotion:
		rot.y += -event.relative.x * mouse_sens * _delta * 500
		rot.x += -event.relative.y * mouse_sens * _delta * 500
		rot.x = min(max(rot.x,-90),90)
		$boy1/tracker.rotation = rot / 180
		
	if event is InputEventMouseButton:
		onHit = (event.button_mask == 1)

func _on_MoveController_Move(speedFront, speedLeft, time):
	Look = global_transform.basis.z
	Left = global_transform.basis.x
	Look = Look.rotated(global_transform.basis.y,rot.y / 180)
	
	if speedFront > 0.1:
		player.play_animation("Standard Walking in place", false, speedFront)
		player.translate(speedFront * Look * _delta * PLAYER_WALK)
	elif speedFront < 0.1:
		player.play_animation("Standard Walking in place", true, abs(speedFront))
		player.translate(speedFront * Look * _delta * PLAYER_WALK)
	else:
		player.play_animation("Standard Breathing Idle")
	

func _on_MoveController_onHit():
	onHit = false

func _on_Button_pressed():
	player.animate($UI/Options.get_selected_id())
