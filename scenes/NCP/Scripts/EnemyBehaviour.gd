extends Node

var alive = true

func hit():
	alive = false
	print("Enemy hit! Alive:", alive)
	
	$MeshInstance3D.visible = false
	$CollisionShape3D.disabled = true

	await get_tree().create_timer(1.0).timeout
	queue_free()
