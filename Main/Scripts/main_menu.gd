extends Node2D



func _on_play_pressed():
	get_tree().change_scene_to_file("res://Main/Scenes/Main.tscn")

func _on_continue_pressed():
	pass 

func _on_quit_game_pressed():
	get_tree().quit()

