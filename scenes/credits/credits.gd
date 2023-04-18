extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(6).timeout
	get_tree().change_scene_to_file("res://scenes/title_screen/title_screen.tscn")


