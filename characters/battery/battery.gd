extends KinematicBody2D

const GRAVITY = 250
const type = "electric"

signal on_hit

export var health: int = 10
export var velocity: Vector2

var player_distance: Vector2 = Vector2(9999, 9999)
var player: KinematicBody2D

onready var animstate = $AnimationTree.get("parameters/playback")

func _ready():
	$DetectArea.connect("body_entered", self, "on_detect")
	$AttackArea.connect("body_entered", self, "on_attack")
	self.connect("on_hit", self, "on_hit")
	if $Sprite.material:
		$Sprite.material = $Sprite.material.duplicate()

func _physics_process(delta):
	if player:
		player_distance = player.global_position - self.global_position
		if player_distance.length() <= 40:
			velocity = Vector2()
			animstate.travel("slam")
		
	if !is_on_floor():
		self.velocity.y = GRAVITY
	
	self.move_and_slide(velocity, Vector2.UP)
	
	if animstate.get_current_node() == "walk":
		self.velocity.x = player_distance.normalized().x * 50
		$AttackArea.position.x = player_distance.normalized().x * 32
		$Sprite.flip_h = player_distance.normalized().x >= 0

func on_detect(body: KinematicBody2D):
	self.player = body
	$DetectArea/CollisionShape2D.set_deferred("disabled", true)
	animstate.travel("walk")

func on_attack(body: KinematicBody2D):
	body.emit_signal("on_hit", 1)

func on_hit():
	self.health -= 1 
	$Sprite.material.set_shader_param("flash", true)
	yield(get_tree().create_timer(0.1), "timeout")
	$Sprite.material.set_shader_param("flash", false)
	
	if self.health <= 0:
		player = null
		animstate.travel("death")
		collision_mask = 1
		collision_layer = 0
		velocity = Vector2()
