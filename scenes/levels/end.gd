extends Node3D

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

			$message.text = "Your performance is unsatisfactory. We have to let you go... Permanently"


	$score.text = "Total Score: " + s
