extends Node

var level = GlobalVars.curr_level
var max_level = GlobalVars.max_level
var transitioning = false

func _ready():
	var retry = get_tree().get_first_node_in_group("retry") as TextureButton
	retry.connect("pressed", on_retry_pressed)

func _process(delta):
	var label = get_tree().get_first_node_in_group("level_label") as Label
	label.text = "Level %d" % level
	if get_enemies_count() == 0 and level < max_level and !transitioning:
		transitioning = true
		var spotlight = get_tree().get_first_node_in_group("spotlight") as PointLight2D
		var spotlight_animation = spotlight.find_child("AnimationPlayer") as AnimationPlayer
		var timer = get_tree().get_first_node_in_group("timer") as Timer
		var time_label = get_tree().get_first_node_in_group("time_label") as Label

		time_label.visible = false
		spotlight_animation.current_animation = "turning_off"
		level += 1
		await get_tree().create_timer(2).timeout
		get_tree().get_first_node_in_group("level").queue_free()


		get_parent().add_child(load("res://scenes/levels/level%d.tscn" % level).instantiate())
		await get_tree().create_timer(1).timeout
		spotlight_animation.current_animation = "turning_on"
		time_label.visible = true
		timer.start()
		GlobalVars.phaseOne = true
		transitioning = false

	if get_enemies_count() == 0 and level == max_level and !transitioning:
		transitioning = true
		var spotlight = get_tree().get_first_node_in_group("spotlight") as PointLight2D
		var spotlight_animation = spotlight.find_child("AnimationPlayer") as AnimationPlayer
		var timer = get_tree().get_first_node_in_group("timer") as Timer
		var time_label = get_tree().get_first_node_in_group("time_label") as Label

		time_label.visible = false
		spotlight_animation.current_animation = "turning_off"

		await get_tree().create_timer(2).timeout
		get_tree().get_first_node_in_group("level").queue_free()
		get_tree().change_scene_to_file("res://scenes/credits/credits.tscn")


func get_enemies_count():
	var count = 0
	var enemies = get_tree().get_nodes_in_group("enemy")

	for enemy in enemies:
		if !enemy.dead:
			count += 1

	return count


func on_retry_pressed():
	GlobalVars.game_over = false
	transitioning = true
	var spotlight = get_tree().get_first_node_in_group("spotlight") as PointLight2D
	var spotlight_animation = spotlight.find_child("AnimationPlayer") as AnimationPlayer
	var timer = get_tree().get_first_node_in_group("timer") as Timer
	var time_label = get_tree().get_first_node_in_group("time_label") as Label

	time_label.visible = false

	get_tree().get_first_node_in_group("level").queue_free()


	get_parent().add_child(load("res://scenes/levels/level%d.tscn" % level).instantiate())
	await get_tree().create_timer(1).timeout
	spotlight_animation.current_animation = "turning_on"
	time_label.visible = true
	timer.start()
	GlobalVars.phaseOne = true
	transitioning = false
