extends CharacterBody2D

var follow: PathFollow2D
var forward = true
@export var speed = 90
var attack_distance = 30

var dead = false

var last_position: Vector2

func _ready():
	$Sprite2D.rotation = 0
	follow = get_parent()

func _process(delta):
	rotation = 0

	if dead:
		$KnifeAttack.visible = false

	if !dead:
		if (forward):
			follow.progress += delta * speed
		else:
			follow.progress -= delta * speed

		update_direction()
		update_sprite()

func update_direction():
	if (follow.progress_ratio == 0):
		forward = true
	elif (follow.progress_ratio == 1):
		forward = false

	$RayCast2D.target_position = (global_position - last_position).normalized() * attack_distance
	$KnifeAttack.position = $RayCast2D.target_position
	$KnifeAttack.global_position.x = clamp(global_position.x + $RayCast2D.target_position.x, GlobalVars.minX, GlobalVars.maxX)
	$KnifeAttack.global_position.y = clamp(global_position.y + $RayCast2D.target_position.y, GlobalVars.minY, GlobalVars.maxY)
	$KnifeAttack.rotation = $RayCast2D.target_position.angle() - 4.8



	last_position = global_position

func update_sprite():
	if forward:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true

	if global_position.x < 180 and !forward:
		$Sprite2D.flip_h = false
	elif global_position.x > 400 and forward:
		$Sprite2D.flip_h = false

func update_ray():
	$RayCast2D.target_position
