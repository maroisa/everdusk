extends State

var initial = false

func enter():
	player.animstate.travel("jump")

func update():
	if not player.is_on_floor():
		player.velocity.y += 15
	else:
		machine.travel("Normal")
	
	player.move_and_slide(player.velocity, Vector2.UP)
