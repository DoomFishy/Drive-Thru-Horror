extends Control

# Note: Change the path to the current world node 
@onready var main = $"../../.."

func _on_resume_pressed ():
	main.pauseMenu()

func _on_quit_pressed():
	get_tree().quit()
	
