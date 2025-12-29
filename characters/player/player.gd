extends KinematicBody2D

signal on_hit

const SPEED = 200
const JUMP_SPEED = 400

var health = 20
var velocity_static: float = 0
var current_destroyable = null

export var velocity: Vector2 = Vector2()

onready var animstate = $AnimationTree.get("parameters/playback")

func _ready():
	$AttackArea.connect("body_entered", self, "on_attack")
	$DestroyArea.connect("area_entered", self, "on_destroyable_entered")
	$DestroyArea.connect("area_exited", self, "on_destroyable_exited")
	$DestroyableMark.set_as_toplevel(true)
	self.connect("on_hit", self, "on_hit")
	$HUD.set_max_health(health)
	$HUD.activate_sanity()

func on_attack(body):
	body.emit_signal("on_hit")
	$HitSound.pitch_scale = rand_range(1, 1.5)
	$HitSound.play()


func on_hit(value):
	self.health -= value
	$HUD.set_health(self.health)
	if self.health <= 0:
		$AnimationTree.active = false
		Switcher.switch_to("res://canvases/death.tscn")
	
	$Sprite.material.set_shader_param("flash", true)
	yield(get_tree().create_timer(0.1), "timeout")
	$Sprite.material.set_shader_param("flash", false)

func on_destroyable_entered(area: Area2D):
	$HUD.set_choice(area.get_parent().type)
	$DestroyableMark.global_position = area.global_position + Vector2(0, -20)
	$DestroyableMark.show()
	current_destroyable = area.get_parent()

func on_destroyable_exited(area: Area2D):
	print(area.name + ": exited")
	$HUD.hide_choice()
	$DestroyableMark.hide()
	current_destroyable = null

func on_selected():
	current_destroyable.get_node("DestroyArea/CollisionShape2D").queue_free()
