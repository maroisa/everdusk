extends State

var initial = false

func enter():
	initial = false
	
	$"../../AttackCollision".position.x = player.velocity_static * 100
	player.velocity.x = player.velocity_static * 50
	
	if player.animstate.get_current_node() == "attack":
		player.animstate.travel("attack2")
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
