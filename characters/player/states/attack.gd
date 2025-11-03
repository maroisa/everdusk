extends State

var initial_state = false

func enter():
	initial_state = false
	player.animstate.travel("Attack")

func update():
	if player.animstate.get_current_node() != "Attack":
		if initial_state:
			initial_state = false
			machine.travel("Normal")
		else:
			initial_state = true
