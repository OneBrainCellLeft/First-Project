extends Node2D

func _process(_delta):
	$UI/Orbs.text = "Orbs: " + str(Utils.orbs)
	$UI/Squares.text = "Squares: " + str(Utils.squares)
	
	if Utils.not_triangle == true:
		$UI/BeforeEnd.visible = true

func _ready():
	Utils.not_triangle = false

func _on_yes_pressed():
	Utils.Save_Game()
	get_tree().change_scene_to_file("res://Main/Scenes/main_menu.tscn")

func _on_no_pressed():
	Utils.not_triangle = false
	$UI/BeforeEnd.visible = false
