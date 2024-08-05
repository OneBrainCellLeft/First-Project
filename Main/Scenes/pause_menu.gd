extends Control

@onready var anim = $AnimationPlayer

var pause = false

func _process(_delta):
	PauseMenu()

func Resume():
	get_tree().paused = false
	anim.play_backwards("appear")


func PauseMenu():
	if Input.is_action_just_pressed("ui_cancel") and !get_tree().paused:
		get_tree().paused = true
		anim.play("appear")
	elif Input.is_action_just_pressed("ui_cancel") and get_tree().paused:
		Resume()

func _on_resume_pressed():
	Resume()

func _on_save_pressed():
	
	Utils.Save_Game()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Main/Scenes/main_menu.tscn")
	get_tree().paused = false
