extends Node3D

@onready var dialogue_ui = get_tree().current_scene.get_node("dialogue_ui/canvas")
@onready var dialogue_animation: AnimationPlayer = get_tree().current_scene.get_node("dialogue_ui/canvas/AnimationPlayer")
@onready var npc_name: RichTextLabel = get_tree().current_scene.get_node("dialogue_ui/canvas/npc_name")
@onready var dialogue_text: RichTextLabel = get_tree().current_scene.get_node("dialogue_ui/canvas/dialogue_text")
@onready var player: CharacterBody3D = get_tree().current_scene.get_node("Player")
@onready var options_container: VBoxContainer = dialogue_ui.get_node("options")

@export_file("*.json") var dialogue_file_path: String = ""
@export var npc: Node3D
@export var npc_display_name: String = "NPC"

var dialogue_data = {}
var current_id = 0
var started = false
var original_speed: float
var has_spoken = false  # 🧠 new flag

func _ready() -> void:
	dialogue_ui.visible = false
	if dialogue_file_path != "":
		_load_dialogue_file(dialogue_file_path)
	else:
		_create_sample_dialogue()

func _load_dialogue_file(path: String) -> void:
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var data = JSON.parse_string(file.get_as_text())
		if typeof(data) == TYPE_DICTIONARY:
			dialogue_data.clear()
			for key in data.keys():
				dialogue_data[int(key)] = data[key]
			print("✅ Dialogue loaded from:", path)
		else:
			push_warning("Invalid JSON structure in: " + path)
	else:
		push_warning("❌ Failed to open dialogue file: " + path)

func start_dialogue(body):
	# 👇 Only start if not already spoken and not mid-dialogue
	if body == player and !started and !has_spoken:
		started = true
		original_speed = player.speed
		player.speed = 0.0
		player.get_node("head").sens = 0.0
		dialogue_ui.visible = true
		npc.look_at(player.global_transform.origin)
		npc.rotation_degrees.x = 0
		npc.rotation_degrees.z = 0
		current_id = 1
		_display_current_dialogue()

func _display_current_dialogue():
	var entry = dialogue_data.get(current_id)
	if entry == null:
		end_dialogue()
		return

	npc_name.text = npc_display_name
	dialogue_text.text = entry["text"]
	dialogue_animation.play("RESET")
	dialogue_animation.play("scroll")

	for child in options_container.get_children():
		child.queue_free()

	for option in entry["options"]:
		var label = Label.new()
		label.text = option["text"]
		options_container.add_child(label)

func _input(event):
	if not started:
		return

	if event is InputEventKey and event.pressed:
		var key_num = event.keycode - KEY_1
		if key_num >= 0 and key_num <= 3:
			_select_option(key_num)

func _select_option(index):
	var entry = dialogue_data.get(current_id)
	if entry == null or index >= entry["options"].size():
		return

	var next_id = entry["options"][index]["next_id"]

	if typeof(next_id) == TYPE_STRING and next_id == "end":
		end_dialogue()
	else:
		current_id = int(next_id)
		_display_current_dialogue()

func end_dialogue():
	player.speed = original_speed
	player.get_node("head").sens = 0.0025
	dialogue_ui.visible = false
	started = false
	has_spoken = true  # 🔒 lock NPC from future dialogue
	current_id = 1

func _create_sample_dialogue():
	dialogue_data = {
		0: {
			"text": "Welcome, traveler. What brings you here?",
			"options": [
				{"text": "1. I'm looking for work.", "next_id": 1},
				{"text": "2. Just passing through.", "next_id": 2},
				{"text": "3. None of your business.", "next_id": 3}
			]
		},
		1: {
			"text": "There’s always work for someone with your skills.",
			"options": [
				{"text": "1. Tell me more.", "next_id": 4},
				{"text": "2. On second thought, nevermind.", "next_id": "end"}
			]
		},
		2: {
			"text": "Safe travels then.",
			"options": [{"text": "1. Goodbye.", "next_id": "end"}]
		},
		3: {
			"text": "Fine, be that way.",
			"options": [{"text": "1. Whatever.", "next_id": "end"}]
		},
		4: {
			"text": "Meet me by the tavern when you’re ready.",
			"options": [{"text": "1. I’ll be there.", "next_id": "end"}]
		}
	}
