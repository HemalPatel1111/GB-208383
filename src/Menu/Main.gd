extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	if GiftData.points < 0:
		$Label.text = "Last Points : -"
	else:
		$Label.text = "Last Points : " + str(GiftData.points)
