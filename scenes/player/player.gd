extends CharacterBody2D

enum states{
	IDLE,
	RUN,
	JUMP,
	FALL,
	ATTACK
}

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 1000.0
const ATTACK_COOLDOWN = 0.9

var attack_timer = 0.0
var state = states.IDLE


@onready var sprite = $AnimatedSprite2D

func _ready():
	state = states.IDLE
	sprite.play("idle")

func _process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	attack_timer += delta

	if Input.is_action_just_pressed("move_up") and is_on_floor() and state != states.ATTACK:
		jump()

	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if state != states.ATTACK or not is_on_floor():
		move_and_slide()
	move(direction)
	handle_attack_input()

	if Game.playerHP <= 0:
		restart_game()

	handle_game_inputs()
	
	if velocity.y > 0 and state != states.ATTACK:
		state = states.FALL
		sprite.play("fall")

func jump():
	state = states.JUMP
	velocity.y = JUMP_VELOCITY
	sprite.play("jump") 

func move(direction):
	if state != states.ATTACK:
		if direction != 0:
			velocity.x = direction * SPEED
			sprite.flip_h = direction < 0
			if is_on_floor() and state != states.JUMP:
				state = states.RUN
				sprite.play("run")
		else:
			velocity.x = 0
			if is_on_floor() and state != states.ATTACK and state != states.JUMP:
				sprite.play("idle")

func handle_attack_input():
	if state != states.ATTACK and attack_timer >= ATTACK_COOLDOWN:
		if Input.is_action_just_pressed("attack_left"):
				attack("attack")
		if Input.is_action_just_pressed("attack_right"):
				attack("strong_attack")
			
func attack(atack_type):
	if state != states.ATTACK:
		attack_timer = 0.0
		state = states.ATTACK
		if atack_type == "attack":
			sprite.play("attack1")
		elif("strong_attack"):
			sprite.play("attack2")
			

func restart_game():
	queue_free()
	Game.playerHP = 3
	Game.playerSouls = 0
	get_tree().change_scene("res://scenes/menu/menu.tscn")

func handle_game_inputs():
	if Input.is_action_just_pressed("quick_save"):
		Utils.save_game()

	if Input.is_action_just_pressed("quick_load"):
		Utils.load_game()

	if Input.is_action_just_pressed("back_to_menu"):
		Utils.back_to_menu()

func _on_animated_sprite_2d_animation_finished():
	if state == states.ATTACK:
		state = states.IDLE
