extends Control

func _ready():
	pass

func _on_Tree_ready():
	for x in range(1,4):
		var btn:= GiftButton.new()
		$Tree.add_child(btn, true)
		btn.load_gift(x, 1)
		btn.set_global_position(Vector2(0, 20 + x * 20))
	pass
