extends TextureButton
class_name MoveControllerTS

export var sensitivity:float = 0.01

var ptr_pos_at_Rest:Vector2 = Vector2(65,65)
var ptr_pos:Vector2 = Vector2()
var ptr_size:Vector2 = Vector2(60,60)

signal Move(speedFront, speedLeft)
signal run(run)

const RUN_WAIT:float = 2.0

var FRONT	:float = 0
var oldFRONT:float = 0
var LEFT	:float = 0
var oldLEFT	:float = 0
var runWait	:float = RUN_WAIT

var onHit	:bool = true
var run		:bool = false

var _player:Player = null

func set_Player(player:Player):
	_player = player

# $"." means class/script itself

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

var index:int = -1

func _touch_started(event: InputEventScreenTouch) -> bool:
	return event.pressed and index == -1

func _touch_ended(event: InputEventScreenTouch) -> bool:
	return not event.pressed and index == event.index

func _input(event):
	if not (event is InputEventScreenTouch or event is InputEventScreenDrag):
		return
		
	if not run:
		if event is InputEventScreenTouch:
			var e:InputEventScreenTouch = event
			
			if _touch_started(event) and get_rect().has_point(e.position):
				ptr_pos = e.position - ptr_pos_at_Rest - get_position()
				_calc_Component(true)
				
				index = e.index
				onHit = true
			elif _touch_ended(e):
				index = -1
				onHit = false
		
		elif event is InputEventScreenDrag:
			var e:InputEventScreenDrag = event
			
			if index == e.index:
				ptr_pos += e.relative
				ptr_pos = min(ptr_pos.length(),100) * ptr_pos.normalized()
				_calc_Component(true)
	else:
		if event is InputEventScreenTouch:
			var e:InputEventScreenTouch = event
			
			if _touch_started(event) and get_rect().has_point(e.position):
				index = e.index
				onHit = true
			elif _touch_ended(e):
				index = -1
				onHit = false
		elif event is InputEventScreenDrag:
			var e:InputEventScreenDrag = event
			
			if index == e.index:
				ptr_pos += e.relative
				ptr_pos = min(ptr_pos.length(),100) * ptr_pos.normalized()
				_calc_Component(true)

func _on_Pointer_gui_input(event):
#	if event is InputEventScreenTouch:
#		var e:InputEventScreenTouch = event
#
#		if _touch_started(event) and get_rect().has_point(e.position):
#			index = e.index
#			onHit = true
#		elif _touch_ended(e):
#			index = -1
#			onHit = false
#
#	elif event is InputEventScreenDrag:
#		var e:InputEventScreenDrag = event
#
#		if index == e.index:
#			ptr_pos += e.relative
#			ptr_pos = min(ptr_pos.length(),100) * ptr_pos.normalized()
#			_calc_Component(true)
	pass

func _on_Move(speedFront, speedLeft):
	_player.set_move(speedFront, speedLeft)

func _on_run(run):
	_player.set_run(run)
