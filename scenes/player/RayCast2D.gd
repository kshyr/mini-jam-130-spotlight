extends RayCast2D


func _ready():
	pass

func _physics_process(delta):
	if is_colliding():
		var targets = get_tree().get_nodes_in_group("enemy")
		if get_collider() in targets and Input.is_action_pressed("attack"):
			var target = get_collider()
			target.dead = true
			target.remove_child(target.find_child("CollisionShape2D"))
			target.remove_child(target.find_child("RayCast2D"))
			var enemy_animation = target.find_child("AnimationPlayer") as AnimationPlayer
			enemy_animation.play("dead")
