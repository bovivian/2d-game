extends CharacterBody2D

const SPEED = 50.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase = false
@onready var animation = get_node("AnimatedSprite2D")
@onready var player = get_node("../../Player")

# default
func _ready():
	animation.play("idle")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	#
	if chase == true:
		if animation.animation != "death":
			animation.play("move")
		#
		var direction = (player.global_position - self.global_position).normalized()
		#
		if direction.x > 0:
			animation.flip_h = true
		else:
			animation.flip_h = false
		#
		velocity.x = direction.x * SPEED
	else:
		if animation.animation != "death":
			animation.play("idle")
		velocity.x = 0
	#
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true
		
func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_player_hit_detection_body_entered(body):
	if body.name == "Player":
		Game.playerSouls += 1 # bug iz-za collision boxov
		death()


func _on_player_hurt_detection_body_entered(body):
	if body.name == "Player":
		Game.playerHP -= 1
		death()
		
func death():
	velocity.x = 0
	chase = false
	animation.play("death")
	await animation.animation_finished
	self.queue_free()
