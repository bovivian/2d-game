# Character that moves and jumps.
class_name Player extends CharacterBody2D

## Horizontal speed in pixels per second.
@export var speed := 350.0
## Vertical acceleration in pixel per second squared.
@export var gravity := 2000.0
## Vertical speed applied when jumping.
@export var jump_impulse := 700.0

@export var glide_max_speed := 700.0
@export var glide_acceleration := 700.0
@export var glide_gravity := 800.0
@export var glide_jump_impulse := 900.0

@onready var sprite := $AnimatedSprite2D
@onready var fsm := $StateMachine


func _process(_delta: float) -> void:
	_update_animation()

func _update_animation():
	# Изменяем направление анимации в зависимости от ввода
	var input_direction_x := Input.get_axis("move_left", "move_right")
	if input_direction_x != 0:
		sprite.flip_h = input_direction_x < 0
