extends KinematicBody2D

signal on_hit

const GRAVITY = 250

var velocity: Vector2
var player: KinematicBody2D

export var health = 5
export var anim_velocity: Vector2

func _ready():
	$DetectArea.connect("body_entered", self, "on_detect")
	$AttackArea.connect("body_entered", self, "on_attack")
	self.connect("on_hit", self, "on_hit")

func _physics_process(delta):
	if health <= 0: return
	
	if !is_on_floor():
		velocity.y = GRAVITY
	
	if player:
		velocity.y += anim_velocity.y
		velocity.x = anim_velocity.x * (player.global_position - self.global_position).normalized().x
	
	move_and_slide(velocity, Vector2.UP)

func on_detect(body: KinematicBody2D):
	player = body
	$DetectArea/CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("jump")

func on_attack(body: KinematicBody2D):
	body.emit_signal("on_hit", 1)

func on_hit():
	self.health -= 1 
	if self.health <= 0:
		$Sprite.modulate.a = 0.5
		$CollisionShape2D.set_deferred("disabled", true)
		$AttackArea/CollisionShape2D.set_deferred("disabled", true)
		$AnimationPlayer.play("idle")
	
	$Sprite.material.set_shader_param("flash", true)
	yield(get_tree().create_timer(0.1), "timeout")
	$Sprite.material.set_shader_param("flash", false)
