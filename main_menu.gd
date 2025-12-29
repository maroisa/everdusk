extends Control

var state = "Main"

func _ready():
	$Paper/Main/VB/PlayButton.connect("pressed", self, "on_play")
	$Paper/Main/VB/OptionButton.connect("pressed", self, "on_option")
	$Paper/Main/VB/ExitButton.connect("pressed", self, "on_exit")
	$Paper/Option/P/VB/BackButton.connect("pressed", self, "on_back")
	$AnimationPlayer.connect("animation_finished", self, "on_anim_finish")
	for i in $Paper.get_children(): i.hide()

func on_anim_finish(anim):
	for i in $Paper.get_children(): i.hide()
	$Paper.get_node(state).show()

func on_play():
	Switcher.switch_to("res://canvases/intro1.tscn")

func on_option():
	state = "Option"
	for i in $Paper.get_children(): i.hide()
	$AnimationPlayer.play("full_unwrap")

func on_exit():
	get_tree().quit()

func on_back():
	state = "Main"
	for i in $Paper.get_children(): i.hide()
	$AnimationPlayer.play("full_unwrap")
