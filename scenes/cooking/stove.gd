extends StaticBody3D

func _ready():
	# Connect Area3D signals
	print("Stove ready")
	$StoveTop.area_entered.connect(Callable(self, "_on_stove_top_area_entered"))
	$StoveTop.area_exited.connect(Callable(self, "_on_stove_top_area_exited"))

func _on_stove_top_area_entered(area):
	if area.is_in_group("patty"): # Checks if the body is a patty
		area.start_cooking()

func _on_stove_top_area_exited (area):
		if area.is_in_group("patty"):
			area.stop_cooking()
