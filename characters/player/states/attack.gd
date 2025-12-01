extends State

var initial = false

var count = 0

func enter():
	initial = false
	count += 1
	
	player.velocity = Vector2(player.velocity_static, 0) * 20
	if player.animstate.get_current_node() == "attack":
		player.animstate.travel("attack2")
		if count > 6:
			yield(get_tree().create_timer(0.3), "timeout")
			$"../../Particles2D".emitting = true
			count = 0
	else:
		player.animstate.travel("attack")

func update():
	if Input.is_action_just_pressed("attack"):
		enter()
	
	if not player.animstate.get_current_node() in ["attack", "attack2"]:
		if !initial:
			initial = true
		else:
			machine.travel("Normal")
	
	player.move_and_slide(player.velocity, Vector2.UP)
