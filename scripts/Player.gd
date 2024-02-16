extends CharacterBody2D

const GRAVITY: float = 9.8
const SPEED: int = 400

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	animated_sprite_2d.play("idle")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = -400
		animated_sprite_2d.play("jump")
	velocity.y += GRAVITY
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = SPEED * direction
		if direction < 0:
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.flip_h = false
		if is_on_floor():
			animated_sprite_2d.play("run")
	else:
		velocity.x = 0
		if is_on_floor():
			animated_sprite_2d.play("idle")
	
	if not is_on_floor():
		if velocity.y >= 0:
			animated_sprite_2d.play("fall")
		else:
			animated_sprite_2d.play("jump")

	move_and_slide()
