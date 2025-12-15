extends KinematicBody2D

var health: int = 0

func _ready():
	$SpawnArea.connect("body_entered", self, "on_spawn")
	$AttackTimer.connect("timeout", self, "on_attack")

func on_spawn(body):
	$AnimationPlayer.play("spawn")
	$SpawnArea/CollisionShape2D.set_deferred("disabled", true)
	$AttackTimer.start()

func on_attack():
	$AnimationPlayer.play("shoot")
