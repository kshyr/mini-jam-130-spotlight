extends CharacterBody2D

@export var speed = 100

var last_nonzero_direction: Vector2
var dead = false

func _ready():
	$Sprite2D.rotation = 0

func _process(delta):

	if !dead and !GlobalVars.phaseOne and !get_tree().get_first_node_in_group("level_manager").transitioning:
		handle_movement()
		handle_attack()
	if dead:
		game_over(delta)


func handle_movement():
	var direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	if direction != Vector2.ZERO:
		last_nonzero_direction = direction

	$RayCast2D.target_position = direction * 15
	$KnifeAttack.position = last_nonzero_direction * 15
	$KnifeAttack.rotation = last_nonzero_direction.angle() - 4.8

	velocity = direction * speed
	move_and_slide()


func handle_attack():
	if Input.is_action_just_pressed("attack"):
		$AnimationPlayer.play("attack")
		$KnifeAttack.visible = true
		$KnifeAttack.frame = randf_range(0, 3)
		await get_tree().create_timer(0.1).timeout
		$KnifeAttack.visible = false


func game_over(delta):
	var spotlight = get_tree().get_first_node_in_group("spotlight") as PointLight2D
	var spotlight_animation = spotlight.find_child("AnimationPlayer") as AnimationPlayer
	spotlight_animation.current_animation = "turning_on"
	spotlight.position = spotlight.position.move_toward(position, delta * 50)
	$AnimationPlayer.play("dead")
	spotlight_at_player_position(spotlight)

func spotlight_at_player_position(spotlight):
	if spotlight.position == position:
		await get_tree().create_timer(3).timeout
		if spotlight.position != position:
			spotlight_at_player_position(spotlight)
		else:
			GlobalVars.game_over = true

