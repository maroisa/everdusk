extends Node
class_name StateMachine

export var initial_state = "Normal"
onready var state: Node = get_node(initial_state)

func _ready():
	for child in get_children():
		child.machine = self
	
	yield(owner, "ready")
	
	state.enter()

func _physics_process(_delta):
	state.update()

func travel(new_state):
	if not has_node(new_state): return
	if state.name == new_state: return
	
	state.exit()
	state = get_node(new_state)
	state.enter()
