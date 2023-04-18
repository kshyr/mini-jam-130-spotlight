extends Timer

var spotlight_animation: AnimationPlayer

func _ready():
	connect("timeout", on_timeout)
	spotlight_animation = get_tree().get_first_node_in_group("spotlight").find_child("AnimationPlayer")

func _process(delta):
	var label = get_tree().get_first_node_in_group("time_label") as Label
	label.text = "%.1f" % time_left



func on_timeout():
	update_phase()

func update_phase():
	GlobalVars.phaseOne = !GlobalVars.phaseOne

	if GlobalVars.phaseOne:
		spotlight_animation.play("turning_on")
	else:
		spotlight_animation.play("turning_off")

