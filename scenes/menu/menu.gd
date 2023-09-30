extends Node2D

func _ready():
	Utils.save_game()
	Utils.load_game()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/world.tscn")

func _on_exit_pressed():
	get_tree().quit()
