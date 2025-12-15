extends KinematicBody2D

const SPEED = 200
const JUMP_SPEED = 400

var velocity_static: float = 0
export var velocity: Vector2 = Vector2()

onready var animstate = $AnimationTree.get("parameters/playback")
