extends Control

func _ready():
	$Paper/C/VB/PlayButton.connect("pressed", self, "on_play")
	$Paper/C/VB/PlayButton.connect("mouse_entered", self, "toggle_text", [true, $Paper/C/VB/PlayButton])
	$Paper/C/VB/PlayButton.connect("mouse_exited", self, "toggle_text", [false, $Paper/C/VB/PlayButton])
	$Paper/C/VB/OptionButton.connect("pressed", self, "on_option")
	$Paper/C/VB/OptionButton.connect("mouse_entered", self, "toggle_text", [true, $Paper/C/VB/OptionButton])
	$Paper/C/VB/OptionButton.connect("mouse_exited", self, "toggle_text", [false, $Paper/C/VB/OptionButton])
	$Paper/C/VB/ExitButton.connect("pressed", self, "on_exit")
	$Paper/C/VB/ExitButton.connect("mouse_entered", self, "toggle_text", [true, $Paper/C/VB/ExitButton])
	$Paper/C/VB/ExitButton.connect("mouse_exited", self, "toggle_text", [false, $Paper/C/VB/ExitButton])
	$AnimationPlayer.connect("animation_finished", self, "on_anim_finish")
	$Paper/C.hide()

func on_anim_finish(anim):
	$Paper/C.show()

func on_play():
	get_tree().change_scene("res://world.tscn")

func on_option(): pass

func on_exit():
	get_tree().quit()

func toggle_text(active: bool, node: Control):
	node.get_node("Active").visible = active
	node.get_node("Normal").visible = !active
