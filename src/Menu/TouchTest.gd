extends Control

var btn:GiftButton = null

func _ready():
	pass

func _on_Tree_ready():
	pass


func _on_Tree_tree_entered():
	for x in range(0,4):
		var item = load("res://src/Control/GiftButton.tscn")
		btn = item.instance()
		$Tree.add_child(btn)
		btn.load_gift(x, 1)
		btn.set_global_position(Vector2(0, 20 + x * 20))
