extends Node2D

var end_valid = false
var not_triangle = false
var triangle = false
var orbs = 0
var squares = 0

const SAVE_PATH = "user://savegame.save"

func Triangle_Valid():
	if end_valid == false and orbs >= 2 and squares >= 30:
		end_valid = true

func Save_Game():
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data = {
	"Orbs" : orbs,
	"Squares" : squares,
	"GoldenTriangle" : triangle
	}
	var jstr = JSON.stringify(data)
	save_file.store_line(jstr)

func Load_Game():
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH):
		if not save_file.eof_reached():
			var current_line = JSON.parse_string(save_file.get_line())
			if current_line:
				orbs = current_line["Orbs"]
				squares = current_line["Squares"]
				triangle = current_line["GoldenTriangle"]

func New_Game():
	orbs = 0
	squares = 0
