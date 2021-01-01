extends Control


var type:String = ""

var p:Vector2 = Vector2()
var dp:Vector2 = Vector2()

var f:= [Vector2(),Vector2(),Vector2(),Vector2(),Vector2()]
var df:= [Vector2(),Vector2(),Vector2(),Vector2(),Vector2()]

var fingerCount = 0

var run:bool = false

func _process(delta):
	$Label.text = "Type : " + type 
	$Label.text += ("\nPointer : " + getPoint(p) + " delta : " + getPoint(dp)) if fingerCount == 0 else ""
	if fingerCount > 0:
		for i in range(0,fingerCount):
			$Label.text += "\nfinger[" + str(i+1) + "]   -> p : " + getPoint(f[i]) + " dp : " + getPoint(df[i])
	if run:
		$Label.text += "\n run"

func getPoint(P:Vector2) -> String:
	return "(" + str(P.x) + "," + str(P.y) + ")"

func _on_Node2D_gui_input(event):
	if event is InputEventMouseButton:
		type = "Mouse Button"
		dp = Vector2()
		p = event.position
		fingerCount = 0
	elif event is InputEventMouseMotion:
		type = "Mouse Motion"
		dp = event.position - p
		p = event.position
		fingerCount = 0
	elif event is InputEvent:
		if event is InputEventScreenTouch:
			var e:InputEventScreenTouch = event
			type = "Screen"
			fingerCount = e.get_index() + 1
			df[e.index] = Vector2()
			f[e.index] = e.position
		if event is InputEventScreenDrag:
			var e:InputEventScreenDrag = event
			type = "Screen"
			fingerCount = e.get_index() + 1
			df[e.index] = e.relative
			f[e.index] = e.position
	else:
		type = "None"


func _on_Move_run(run):
	$".".run = run
