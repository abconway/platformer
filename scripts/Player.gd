extends CharacterBody2D
class_name Player

const GRAVITY: float = 9.8
const SPEED: int = 400

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	animated_sprite_2d.play("idle")

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY
	if is_on_floor():
		animated_sprite_2d.play("run")
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = -250
			animated_sprite_2d.play("jump")
	else:
		if velocity.y >= 0:
			animated_sprite_2d.play("fall")
		else:
			animated_sprite_2d.play("jump")
	move_and_slide()
