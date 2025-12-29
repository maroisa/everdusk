extends CanvasLayer

func switch_to(scene: String):
	$AnimationPlayer.play("fade")
	yield($AnimationPlayer, "animation_finished")
	print(scene)
	get_tree().change_scene(scene)
	$AnimationPlayer.play_backwards("fade")
