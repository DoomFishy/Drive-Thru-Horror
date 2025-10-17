extends Node

func hit():
	$CollisionShape3D.disabled = true
	get_parent().get_child(get_parent().get_parent().index).visible = false
	get_parent().get_parent().index += 1
	$"../../../order_drop_off".current_index += 1
	
	
	Global.order_started = false
	$fire.emitting = true
	$smoke.emitting = true
	
	await get_tree().create_timer(1).timeout
	
	$CollisionShape3D.disabled = false
