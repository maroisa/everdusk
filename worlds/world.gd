extends Node2D

func _ready():
	$DeathZone.connect("body_entered", self, "on_reset")
	$WinArea.connect("body_entered", self, "on_win")

func on_reset(body):
	get_tree().reload_current_scene()

func on_win():
	Switcher.switch_to("res://canvases/outro.tscn")
