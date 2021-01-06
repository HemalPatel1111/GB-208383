extends Control

var btn:GiftButton = null

func _ready():
	pass

func _on_Tree_ready():
	pass


func _on_Tree_tree_entered():
	for x in range(0,3):
		var item = load("res://src/Control/GiftButton.tscn")
		btn = item.instance()
		$Tree.add_child(btn)
		btn.load_gift(x, x)
		btn.set_global_position(Vector2(0, 20 + x * btn.get_rect().size.y))
