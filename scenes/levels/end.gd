extends Node3D

var jumpscare: bool =false

func _ready() -> void:
	$Label.text = "Correct Orders: " + str(Global.submission[0]) + "\n" + "Incorrect Orders: " + str(Global.submission[1]) + "\n" + "Monster Orders: " + str(Global.submission[2])

	var s : String = ""
	$message.text = "Your service is acceptable."
	match Global.score:
		4:
			s = "A+"
		3:
			s = "A"
		_:
			s = "F"
			jumpscare = true

	$message.text = "Your performance is unsatisfactory. We have to let you go... Permanently"
	$score.text = "Total Score: " + s

func _process(_delta: float) -> void:
	if jumpscare == true and not $AnimationPlayer.is_playing():
		scare()

func scare():
	$Jumpscare2.visible = true
	$AudioStreamPlayer.playing = true
	
	await get_tree().create_timer(2).timeout
	
	get_tree().change_scene_to_file("res://scenes/mainMenu/Main_Menu.tscn")
