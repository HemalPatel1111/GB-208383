extends TextureButton

export var antiRotation:bool= true
export var sensitivity:float = 0.01

var ptr_pos_at_Rest:Vector2 = Vector2(65,65)
var ptr_pos:Vector2 = Vector2()
var ptr_size:Vector2 = Vector2(60,60)

var _rotResistance:Vector2 = Vector2()

signal Move(speedFront, speedLeft)
signal onHit()

var FRONT :float = 0
var oldFRONT :float = 0
var LEFT  :float = 0
var oldLEFT  :float = 0
var onHit:bool=false

func _process(delta):
	var pos = $Pointer.get_position()
	var deltaPos = ptr_pos_at_Rest - pos
	
	oldFRONT = FRONT
	oldLEFT = LEFT
	FRONT = ptr_pos.y * sensitivity
	LEFT = ptr_pos.x * sensitivity
	
	if(!onHit):
		$Pointer.set_position(pos + deltaPos / 5)
		ptr_pos = pos - ptr_pos_at_Rest
		if ptr_pos.length() > 0.1:
			emit_signal("Move", FRONT, LEFT)
	else:
		$Pointer.set_position(ptr_pos_at_Rest + ptr_pos)

func _on_gui(event):
	if event is InputEventMouseButton:
		if event.button_mask == 1 :
			onHit = true
			emit_signal("onHit")
		else :
			onHit = false

func _on_Move_gui_input(event):
	_on_gui(event)
	
	if _rotResistance.length() > 0:
		_rotResistance *= 0
	
	if event is InputEventMouseMotion:
		if onHit:
			if antiRotation:
				_rotResistance = event.relative
	if onHit:
		var dir = event.position - ptr_pos_at_Rest - ptr_size / 2
		ptr_pos = min(dir.length(),100) * dir.normalized()		
	else:
		FRONT = 0
		LEFT = 0

func _on_Pointer_gui_input(event):
	_on_gui(event)
	
	if _rotResistance.length() > 0:
		_rotResistance *= 0
	
	if event is InputEventMouseButton:
		if onHit :
			ptr_pos = event.position - ptr_size / 2
			
			emit_signal("Move", FRONT, LEFT)
	if event is InputEventMouseMotion:
		var delta = event.relative
		
		if onHit:
			ptr_pos += delta
			ptr_pos = min(ptr_pos.length(),100) * ptr_pos.normalized()
			if antiRotation:
				_rotResistance = event.relative
			
			emit_signal("Move", FRONT, LEFT)
		#else:
		#	FRONT = 0
		#	LEFT = 0
