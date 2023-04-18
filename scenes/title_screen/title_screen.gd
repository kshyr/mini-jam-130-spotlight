extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$SubViewport/AnimationPlayer.play("title_screen_sounds_1")
	$SubViewport/AnimationPlayer.queue("title_screen_sounds_1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_animation_finished():
	$SubViewport/AnimationPlayer.play("title_screen_sounds_1")
