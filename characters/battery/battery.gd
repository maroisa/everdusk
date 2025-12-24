extends KinematicBody2D

signal on_hit

export var health: int = 10
export var velocity: Vector2

var player_distance: Vector2 = Vector2(9999, 9999)
var player: KinematicBody2D

onready var animtree = $AnimationTree.get("parameters/playback")

func _ready():
	$DetectArea.connect("body_entered", self, "on_detect")
	$AttackArea.connect("body_entered", self, "on_attack")
	self.connect("on_hit", self, "on_hit")

func _physics_process(delta):
	
	if player:
		player_distance = player.global_position - self.global_position
	
	if animtree.get_current_node() == "walk":
		self.velocity.x = player_distance.normalized().x * 50
		$AttackArea.position.x = player_distance.normalized().x * 40
		$Sprite.flip_h = player_distance.normalized().x >= 0
	
	if player_distance.length() <= 40:
		velocity = Vector2()
		animtree.travel("slam")
	
	
	self.move_and_slide(velocity, Vector2.UP)

func on_detect(body: KinematicBody2D):
	self.player = body
	$DetectArea/CollisionShape2D.set_deferred("disabled", true)
	animtree.travel("walk")

func on_attack(body: KinematicBody2D):
	body.emit_signal("on_hit", 1)

func on_hit():
	self.health -= 1 
	if self.health <= 0:
		$Sprite.modulate.a = 0.5
		$CollisionShape2D.set_deferred("disabled", true)
	
	$Sprite.material.set_shader_param("flash", true)
	yield(get_tree().create_timer(0.1), "timeout")
	$Sprite.material.set_shader_param("flash", false)
