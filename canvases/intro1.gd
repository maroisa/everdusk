extends Control

func _ready():
	$AnimationPlayer.connect("animation_finished", self, "on_finish")
	$M/SkipButton.connect("pressed", self, "on_skip")
	$C/Label.percent_visible = 0
	$C/Label.text = ""

func on_finish(anim):
	Switcher.switch_to("res://worlds/world.tscn")

func on_skip():
	Switcher.switch_to("res://worlds/world.tscn")
