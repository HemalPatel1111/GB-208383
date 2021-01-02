extends TextureButton
class_name MoveController

export var sensitivity:float = 0.01
export var RUN_WAIT:float = 2.0

var ptr_pos_at_Rest:Vector2 = Vector2(65,65)
var ptr_pos:Vector2 = Vector2()
var ptr_size:Vector2 = Vector2(60,60)

signal Move(speedFront, speedLeft)
signal onHit()
signal run(run)

var runWait:float = RUN_WAIT

var run:bool = false

var FRONT :float = 0
var oldFRONT :float = 0
var LEFT  :float = 0
var oldLEFT  :float = 0
var onHit:bool=false

func _process(delta):
	var pos = $Pointer.get_position()
	var deltaPos = ptr_pos_at_Rest - pos
	
	_calc_Component()
	
	if ptr_pos.y <= -90:
		if runWait > 0:
			runWait -= delta
		else:
			runWait = 0
			run = true
			emit_signal("run", run)
	else:
		runWait = RUN_WAIT
		run = false
		emit_signal("run", run)

	if not run:
		if(!onHit):
			$Pointer.set_position(pos + deltaPos / 5)
			ptr_pos = pos - ptr_pos_at_Rest
			if ptr_pos.length() > 0.1:
				emit_signal("Move", FRONT, LEFT)
		else:
			$Pointer.set_position(ptr_pos_at_Rest + ptr_pos)
	else:
		if(onHit):
			$Pointer.set_position(ptr_pos_at_Rest + ptr_pos)

func _calc_Component(signalIt:bool = false):
	oldFRONT = FRONT
	oldLEFT = LEFT
	FRONT = ptr_pos.y * sensitivity
	LEFT = ptr_pos.x * sensitivity
	if signalIt:
		emit_signal("Move", FRONT, LEFT)

func _on_gui(event):
	if event is InputEventMouseButton:
		if event.button_mask == 1 :
			onHit = true
			emit_signal("onHit")
		else :
			onHit = false

func _on_Move_gui_input(event):
	_on_gui(event)
	
	if not run:
		if event is InputEventMouseButton:
			if onHit :
				var dir = event.position - ptr_pos_at_Rest - ptr_size / 2
				ptr_pos = min(dir.length(),100) * dir.normalized()
				_calc_Component(true)
				
		if event is InputEventMouseMotion:
			if onHit:
				var dir = event.position - ptr_pos_at_Rest - ptr_size / 2
				ptr_pos = min(dir.length(),100) * dir.normalized()
			
			_calc_Component(true)
		else:
			FRONT = 0
			LEFT = 0

func _on_Pointer_gui_input(event):
	_on_gui(event)
	
	if event is InputEventMouseButton and not run:
		if onHit :
			ptr_pos = event.position - ptr_size / 2
			_calc_Component(true)
	if event is InputEventMouseMotion:
		var delta = event.relative
		
		if onHit:
			ptr_pos += delta
			ptr_pos = min(ptr_pos.length(),100) * ptr_pos.normalized()
			
			_calc_Component(true)
		#else:
		#	FRONT = 0
		#	LEFT = 0
