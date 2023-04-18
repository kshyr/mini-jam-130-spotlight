extends PointLight2D

var minX = 128
var maxX = 480
var minY = 112
var maxY = 288

const SPOTLIGHT_SPEED = 50
var last_position: Vector2

func _ready():
	pass


func _process(delta):
	var player = get_tree().get_first_node_in_group("player")
	if player and !player.dead:
		var target_position = Vector2(
			clamp(get_global_mouse_position().x, minX + 2, maxX - 2),
			clamp(get_global_mouse_position().y, minY + 2, maxY - 2)
		)
		if GlobalVars.phaseOne:
			$hum.play("moving")
			if last_position != position:
				$Hum.volume_db = -6
				$Hum.pitch_scale = 10
			else:
				$Hum.volume_db = -17
				$Hum.pitch_scale = 0
		else:

			$hum.stop()
		last_position = position
		# position = lerp(position, target_position, SPOTLIGHT_SPEED_MODIFIER * delta)
		target_position = lerp(position, target_position, delta * SPOTLIGHT_SPEED)
		position = position.move_toward(target_position, delta * SPOTLIGHT_SPEED)


