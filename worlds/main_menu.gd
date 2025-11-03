extends Control

func _ready():
	$M/Main/VB/PlayButton.connect("pressed", self, "on_play")
	$M/Main/VB/OptionButton.connect("pressed", self, "on_option")
	$M/Main/VB/ExitButton.connect("pressed", self, "on_exit")
	
	$M/Play/VB/HB/Back.connect("pressed", self, "on_back")
	
	for i in $M/Play/VB/Saves.get_children():
		i.connect("pressed", self, "on_save_selected")


func on_play():
	$M/Main.hide()
	$M/Play.show()

func on_back():
	$M/Play.hide()
	$M/Main.show()

func on_option():
	pass

func on_exit():
	get_tree().quit()

func on_save_selected():
	get_tree().change_scene("res://worlds/world.tscn")
