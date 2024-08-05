extends Node2D

func _on_new_game_pressed():
	Utils.New_Game()
	get_tree().change_scene_to_file("res://Main/Scenes/Main.tscn")

func _on_continue_pressed():
	Utils.Load_Game()
	get_tree().change_scene_to_file("res://Main/Scenes/Main.tscn")

func _on_quit_game_pressed():
	get_tree().quit()

func _ready():
	Utils.Load_Game()

func _process(_delta):
	if Utils.triangle == true:
		$GoldenTriangle.visible = true
