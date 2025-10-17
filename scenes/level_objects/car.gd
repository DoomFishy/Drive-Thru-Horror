extends Node3D

@export var button : StaticBody3D
@export var dialogue : Node3D

var index : int = 0
var anim : AnimationPlayer

func _ready() -> void:
	anim = get_child(0)

func arrive():
	anim.play("arrive")
	colision(false)
	get_node("CarHolder").get_child(index).visible = true

func exit():
	anim.play("exit")
	await anim.animation_finished
	get_node("CarHolder").get_child(index).visible = false
	if index < get_node("CarHolder").get_child_count() - 1:
		index += 1

func colision(value: bool):
	if index < get_node("CarHolder").get_child_count() - 1:
		get_node("CarHolder").get_child(index).find_child("dialogue_trigger").collision.disabled = value
