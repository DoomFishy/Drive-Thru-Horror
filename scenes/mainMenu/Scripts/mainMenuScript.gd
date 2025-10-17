extends VBoxContainer

const TEST_WORLD = preload("res://scenes/levels/map.tscn")
const TUTORIAL = preload("res://scenes/levels/tutorial.tscn")

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(TEST_WORLD)


func _on_option_pressed() -> void:
	get_tree().change_scene_to_packed(TUTORIAL)


func _on_quit_pressed() -> void:
	get_tree().quit()
