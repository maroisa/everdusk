extends State

func enter():
	player.animstate.travel("walk")

func update():
	var direction = Input.get_axis("left", "right")
	player.velocity.x = direction * player.SPEED
	
	if player.velocity.x != 0:
		player.animstate.travel("walk")
		player.velocity_static = direction
	else:
		player.animstate.travel("idle")
	
	if not player.is_on_floor():
		machine.travel("Jump")
	else:
		if Input.is_action_just_pressed("jump"):
			player.velocity.y = -player.JUMP_SPEED
			machine.travel("Jump")
	
	if Input.is_action_just_pressed("attack"):
		machine.travel("Attack")
	
	player.move_and_slide(player.velocity, Vector2.UP)
