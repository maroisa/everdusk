extends Node2D

func _ready():
	$DeathZone.connect("body_entered", self, "on_reset")

func on_reset(body):
	get_tree().reload_current_scene()
