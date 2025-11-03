extends KinematicBody2D

const SPEED = 150

var state = states.MOVE
var velocity_static = Vector2()
var velocity = Vector2()

onready var animstate = $AnimationTree.get("parameters/playback")

enum states {
	MOVE
	JUMP
	ATTACK
}

var initial_state = false

func move_state():
	var direction = Input.get_axis("left", "right")
	velocity.x = lerp(velocity.x, direction * SPEED, 0.2)
	
	if $JumpTimer.is_stopped():
		velocity.y += 10
	
	if velocity.x != 0:
		animstate.travel("Walk")
		velocity_static = velocity
	else:
		animstate.travel("Idle")
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_select") and $JumpTimer.is_stopped():
			velocity.y = -225
			$JumpTimer.start()
			state = states.JUMP
			
		if Input.is_action_just_pressed("attack"):
			animstate.travel("Attack")
			state = states.ATTACK
	
	move_and_slide(velocity, Vector2.UP)

func attack_state():
	if Input.is_action_just_pressed("attack"):
		animstate.travel("Attack")
		state = states.ATTACK
	
	if animstate.get_current_node() != "Attack":
		if initial_state:
			initial_state = false
			state = states.MOVE
		else:
			initial_state = true

func jump_state():
	print("JUmped")
	if $JumpTimer.is_stopped():
		velocity.y += 10
	
	if is_on_floor():
		state = states.MOVE
	move_and_slide(velocity, Vector2.UP)

func _physics_process(delta):
	if state == states.MOVE: move_state()
	if state == states.ATTACK: attack_state()
	if state == states.JUMP: jump_state()
