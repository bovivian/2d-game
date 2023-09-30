extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation = get_node("AnimationPlayer")

func _ready():
	animation.play("idle")

func attack():
	if Input.is_action_just_pressed("attack_left"):
		animation.play("attack1")
	if Input.is_action_just_pressed("attack_right"):
		animation.play("attack2")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation.play("jump")
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			animation.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			animation.play("idle")
	
	if velocity.y > 0:
		animation.play("fall")

	move_and_slide()
	attack()
	
	if Game.playerHP <= 0:
		queue_free()
		Game.playerHP = 3
		Game.playerSouls = 0
		get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
		
	if Input.is_action_just_pressed("quick_save"):
		Utils.save_game()
			
	if Input.is_action_just_pressed("quick_load"):
		Utils.load_game()
