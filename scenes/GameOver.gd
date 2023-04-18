extends Control

func _ready():
	hide()
	$VBoxContainer2/Quit.connect("pressed", on_quit_pressed)
	$VBoxContainer2/Retry.connect("pressed", on_retry_pressed)

func _process(delta):
	if GlobalVars.game_over:
		show()


func on_quit_pressed():
	get_tree().change_scene_to_file("res://scenes/title_screen/title_screen.tscn")
	GlobalVars.game_over = false


func on_retry_pressed():
	GlobalVars.game_over = false
	hide()
