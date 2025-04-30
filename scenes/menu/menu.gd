extends Node2D


func _ready():
	Utils.save_game()
	Utils.load_game()
	$Settings.visible = false
	$Menu.visible = true


func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")


func _on_exit_pressed():
	get_tree().quit()


func _on_settings_pressed():
	$Menu.visible = false
	$Settings.visible = true


func _on_back_pressed() -> void:
	$Settings.visible = false
	$Menu.visible = true
