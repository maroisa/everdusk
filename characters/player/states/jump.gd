extends State

var initial = false

func enter():
	player.animstate.travel("jump")

func update():
	if not player.is_on_floor():
		player.velocity.y += 15
	else:
		
		machine.travel("Normal")
	
	player.velocity.x = lerp(player.velocity.x, Input.get_axis("left", "right") * player.SPEED, 0.05)
	player.velocity_static = player.velocity.normalized().x * 10
	
	player.move_and_slide(player.velocity, Vector2.UP)
