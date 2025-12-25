extends Control

func _ready():
	$AnimationPlayer.connect("animation_finished", self, "on_finish")
	$C/Label.percent_visible = 0
	$C/Label.text = ""

func on_finish(anim):
	get_tree().change_scene("res://worlds/world.tscn")
