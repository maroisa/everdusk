extends CanvasLayer

const MAX_SANITY = 100

var player: KinematicBody2D

func _ready():
	$SanityTimer.connect("timeout", self, "on_sanity_drained")
	$ColorRect.material.set_shader_param("intensity", 0)

func set_max_health(value):
	$M/HB/HealthBar.max_value = value
	$M/HB/HealthBar.value = value

func set_health(value):
	$M/HB/HealthBar.value = value

func activate_sanity():
	$M/HB/SanityBar.max_value = MAX_SANITY
	$M/HB/SanityBar.value = MAX_SANITY
	$SanityTimer.start()

func on_sanity_drained():
	$M/HB/SanityBar.value -= 1
	$ColorRect.material.set_shader_param("intensity", 2 - ($M/HB/SanityBar.value / 100 * 2))
