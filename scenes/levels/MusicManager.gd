extends Node

var current_bgs = ""
var previous_scene : Node = null

func _ready():
	previous_scene = get_tree().current_scene
	_on_scene_changed()


func _process(_delta):
	if previous_scene != get_tree().current_scene:
		previous_scene = get_tree().current_scene
		_on_scene_changed()
		print("Scene changed: ", previous_scene)


func _on_scene_changed():
	var scene = get_tree().current_scene
	if scene == null:
		return
	stop_music()
	match scene.name:
		"Main Menu":
			play_music("res://assets/audio/Pixel-Heart.ogg")
		"Level 1":
			play_music("res://assets/audio/Epic-Dawn-Voyage.ogg")
		"Level 2":
			play_music("res://assets/audio/Pixel-Magic.ogg")
		_:
			stop_music()


func play_music(path: String):
	if current_bgs == path:
		return
	current_bgs = path
	SoundManager.play_bgs(path)


func stop_music():
	if SoundManager.is_playing(current_bgs):
		SoundManager.stop_all()
		current_bgs = ""
