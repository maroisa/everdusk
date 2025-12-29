extends CanvasLayer

func _ready():
	$Label.visible_characters = 0
	$Label.percent_visible = 0
	$AnimationPlayer.connect("animation_finished", self, "on_finish")

func on_finish(anim_name):
	Switcher.switch_to("res://worlds/world.tscn")
