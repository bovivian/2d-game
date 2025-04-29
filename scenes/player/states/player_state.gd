class_name PlayerState extends State

const IDLE = "Idle"
const RUNNING = "Running"
const JUMPING = "Jumping"
const FALLING = "Falling"
const GLIDING = "Gliding"

var player: PlatformerController2D


func _ready() -> void:
	await owner.ready
	print(owner)
	player = owner as PlatformerController2D
	print(player)
	await player.ready
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
