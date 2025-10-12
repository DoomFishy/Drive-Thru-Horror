extends VBoxContainer

const TEST_WORLD = preload("uid://buahw34qee6w5")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(TEST_WORLD)


func _on_option_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
