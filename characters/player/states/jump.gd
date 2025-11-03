extends State

func enter():
	player.velocity.y = -225
	$"../../JumpTimer".start()

func update():
	print("JUmped")
	if $"../../JumpTimer".is_stopped():
		player.velocity.y += 10
	
	if player.is_on_floor():
		machine.travel("Normal")
	
	player.move_and_slide(player.velocity, Vector2.UP)
