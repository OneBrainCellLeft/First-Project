extends Node2D

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Main/Scenes/1_st_stage.tscn")

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Main/Scenes/settings.tscn")

func _on_quit_game_pressed():
	get_tree().quit()
