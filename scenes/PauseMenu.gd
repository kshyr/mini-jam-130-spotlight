extends Control

func _ready():
	hide()
	$VBoxContainer/VBoxContainer/Resume.connect("pressed", on_resume_pressed)
	$VBoxContainer/VBoxContainer/Quit.connect("pressed", on_quit_pressed)

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			get_tree().paused = false
			hide()
		else:
			get_tree().paused = true
			show()


func on_resume_pressed():
	get_tree().paused = false
	hide()

func on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/title_screen/title_screen.tscn")
