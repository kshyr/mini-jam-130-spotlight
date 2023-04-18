extends TextureButton

@export var to_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", on_button_pressed)


func on_button_pressed():
	# get_tree().change_scene_to_file("res://scenes/tutorial/tutorial.tscn")
	get_tree().change_scene_to_packed(to_scene)
