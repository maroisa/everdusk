extends State

func update():
	var direction = Input.get_axis("left", "right")
	player.velocity.x = lerp(player.velocity.x, direction * 150, 0.2)
	
	if $"../../JumpTimer".is_stopped():
		player.velocity.y += 10
	
	if player.velocity.x != 0:
		player.animstate.travel("Walk")
		player.velocity_static = player.velocity
	else:
		player.animstate.travel("Idle")
		
	if player.is_on_floor():
		if Input.is_action_just_pressed("ui_select") and $"../../JumpTimer".is_stopped():
			machine.travel("Jump")
			
		if Input.is_action_just_pressed("attack"):
			machine.travel("Attack")
	
	player.move_and_slide(player.velocity, Vector2.UP)
