extends Node3D

@onready var dialogue_ui = get_tree().current_scene.get_node("dialogue_ui/canvas")
@onready var dialogue_animation: AnimationPlayer = get_tree().current_scene.get_node("dialogue_ui/canvas/AnimationPlayer")
@onready var npc_name: RichTextLabel = get_tree().current_scene.get_node("dialogue_ui/canvas/npc_name")
@onready var dialogue_text: RichTextLabel = get_tree().current_scene.get_node("dialogue_ui/canvas/dialogue_text")
@onready var player: CharacterBody3D = get_tree().current_scene.get_node("Player")

@export var dialogues: Array[String]
@export var npc_names: Array[String]
@export var npc: Node3D

var current_dialogue = -1
var started = false
var original_speed: float

func _ready() -> void:
	dialogue_ui.get_node("continue").connect("pressed", Callable(self,"continue_dialogue"))

func start_dialogue(body):
	if body == player and !started:
		started = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		original_speed = player.speed
		player.speed = 0.0
		player.get_node("head").sens = 0.0
		dialogue_ui.visible = true
		npc.look_at(player.global_transform.origin)
		npc.rotation_degrees.x = 0
		npc.rotation_degrees.z = 0
		continue_dialogue()

func end_dialogue():
	player.speed = original_speed
	player.get_node("head").sens = 0.0025
	dialogue_ui.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func continue_dialogue():
	current_dialogue += 1
	if current_dialogue < dialogues.size():
		dialogue_text.text = dialogues[current_dialogue]
		npc_name.text = npc_names[current_dialogue]
		dialogue_animation.play("RESET")
		dialogue_animation.play("scroll")
	else:
		end_dialogue()
