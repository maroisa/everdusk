extends CanvasLayer

func _ready():
	yield($AnimationPlayer, "animation_finished")
	Switcher.switch_to("res://main_menu.tscn")
