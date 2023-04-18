extends RayCast2D

func _physics_process(delta):
	if is_colliding():
		var target = get_tree().get_first_node_in_group("player")
		if get_collider() == target:
			target.dead = true

