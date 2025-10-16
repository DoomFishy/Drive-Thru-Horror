extends Area3D

@export var animPlayer : AnimationPlayer

func _on_body_entered(_body: Node3D) -> void:
	animPlayer.play("window_open")


func _on_body_exited(_body: Node3D) -> void:
	animPlayer.play_backwards("window_open")
