extends Spatial

var mouse_sens = 0.05
var rot:Vector3 = Vector3(0,0,0)
var pos:Vector3 = Vector3(0,0,0)
var UP:Vector3 = Vector3(0,1,0)
var Look:Vector3 = Vector3()
var Left:Vector3 = Vector3()

onready var player:Player = $boy1
var onHit:bool = false

func _ready():
	pos = $Camera.translation
	rot = $Camera.rotation * 180
	player.loadAnimation()
	var list = player.AnimationList
	
	for x in list:
		var anim:Animation =  $boy1/AnimationPlayer.get_animation(x)
		if anim.has_loop() :
			x = "L " + x
		$Options.add_item(x)
	
func _process(delta):
	pass

func _input(event):
	if onHit and event is InputEventMouseMotion:
		rot.y += -event.relative.x * mouse_sens * 5
		rot.x += -event.relative.y * mouse_sens
		rot.x = min(max(rot.x,-90),90)
		$Camera.rotation = rot / 180
		
	if event is InputEventMouseButton:
		onHit = (event.button_mask == 1)

func _on_MoveController_Move(speedFront, speedLeft, time):
	Look = global_transform.basis.z
	Left = global_transform.basis.x
	
	pos += speedFront * Look.rotated(global_transform.basis.y,rot.y / 180) * time / 100
	pos += speedLeft * Left.rotated(global_transform.basis.y,rot.y / 180) * time / 100
	$Camera.translation = pos

func _on_MoveController_onHit():
	onHit = false

func _on_Button_pressed():
	player.animate($Options.get_selected_id())
