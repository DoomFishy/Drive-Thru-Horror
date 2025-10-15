extends Node3D

# Note: Change the path to the current world thats running
@onready var pause_menu = $CookingWorld/TestWorld/PauseMenu
var paused = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		get_tree().paused = false
		pause_menu.hide()
		Engine.time_scale = 1
	else: 
		get_tree().paused = true
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused
