extends KinematicBody2D

signal on_hit

const GRAVITY = 80

var velocity: Vector2
export var health = 5

func _ready():
	$DetectArea.connect("body_entered", self, "on_detect")
	self.connect("on_hit", self, "on_hit")

func _physics_process(delta):
	if health <= 0: return
	
	if !is_on_floor():
		velocity.y = GRAVITY
	
	move_and_slide(velocity, Vector2.UP)

func on_detect(body: KinematicBody2D):
	$DetectArea/CollisionShape2D.set_deferred("disabled", true)


func on_hit():
	self.health -= 1 
	if self.health <= 0:
		$Sprite.modulate.a = 0.5
		$CollisionShape2D.set_deferred("disabled", true)
	
	$Sprite.material.set_shader_param("flash", true)
	yield(get_tree().create_timer(0.1), "timeout")
	$Sprite.material.set_shader_param("flash", false)
