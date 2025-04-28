extends Node

var current_bgm = ""
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
			play_music("res://assets/audio/Pixel-Heart.ogg", -20.0)
		"Level 1":
			play_music("res://assets/audio/Epic-Dawn-Voyage.ogg", -10.0)
		"Level 2":
			play_music("res://assets/audio/Pixel-Magic.ogg", -10.0)
		_:
			stop_music()


func play_music(path: String, volume: float):
	if current_bgm == path:
		return
	current_bgm = path
	SoundManager.play_bgs(path, 0.0, volume)


func stop_music():
	if SoundManager.is_playing(current_bgm):
		SoundManager.stop_all()
		current_bgm = ""
