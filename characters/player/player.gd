extends KinematicBody2D

signal on_hit

const SPEED = 200
const JUMP_SPEED = 400

var health = 20

var velocity_static: float = 0
export var velocity: Vector2 = Vector2()

onready var animstate = $AnimationTree.get("parameters/playback")

func _ready():
	$AttackArea.connect("body_entered", self, "on_attack")
	self.connect("on_hit", self, "on_hit")

func on_attack(body):
	body.emit_signal("on_hit")

func on_hit(value):
	self.health -= value
	if self.health <= 0:
		$AnimationTree.active = false
	$Sprite.material.set_shader_param("flash", true)
	yield(get_tree().create_timer(0.1), "timeout")
	$Sprite.material.set_shader_param("flash", false)
