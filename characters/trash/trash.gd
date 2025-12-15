extends KinematicBody2D

signal on_hit

export var health: int = 3

func _ready():
	$SpawnArea.connect("body_entered", self, "on_spawn")
	$AttackTimer.connect("timeout", self, "on_attack")
	connect("on_hit", self, "on_hit")

func on_spawn(body):
	$AnimationPlayer.play("spawn")
	$SpawnArea/CollisionShape2D.set_deferred("disabled", true)
	$AttackTimer.start()

func on_attack():
	$AnimationPlayer.play("shoot")

func on_hit():
	self.health -= 1 
	if self.health <= 0:
		$AttackTimer.stop()
		$AnimationPlayer.play("die")
		$CollisionShape2D.set_deferred("disabled", true)
	
	$Sprite.material.set_shader_param("flash", true)
	yield(get_tree().create_timer(0.1), "timeout")
	$Sprite.material.set_shader_param("flash", false)
