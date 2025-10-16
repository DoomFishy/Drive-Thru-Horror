extends Node

var alive = true

func hit():
	alive = false
	print("Enemy hit! Alive:", alive)
	
	$MeshInstance3D.visible = false
	$CollisionShape3D.disabled = true
	
	get_parent().get_parent().get_child(get_parent().get_parent().index).visible = false

	await get_tree().create_timer(1.0).timeout
	queue_free()
