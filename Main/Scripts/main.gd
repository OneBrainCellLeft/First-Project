extends Node2D

func _process(delta):
	$UI/Orbs.text = "Orbs: " + str(Utils.Orbs)
