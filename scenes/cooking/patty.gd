extends Area3D

enum State {RAW, COOKING, COOKED, BURNT} # states of patty
var state = State.RAW
# cooking times
var cooking_time : float = 0.0 
var max_cooking_time: float = 10.0
var burn_time: float = 20.0
# is patty on stove
var is_on_stove: bool = false
# status of print messages
var cooked_printed: bool = false
var burnt_printed: bool = false
var ingredientName = "patty"

func _ready():
	# Cache the mesh material for quick access
	print("Patty script ready!")
	$MeshInstance3D.material_override = $MeshInstance3D.get_active_material(0).duplicate()
	
func start_cooking (): # cooking function
	is_on_stove = true
	cooked_printed = false  # RESET for this specific patty
	burnt_printed = false   # RESET for this specific patty
	print ("Patty is cooking on stove.")
	$smoke.emitting = true
	$AudioStreamPlayer3D.playing = true
		
func stop_cooking (): # when the patty stops cooking
	is_on_stove = false
	print ("Patty stopped cooking.")
	$smoke.emitting = false
	$AudioStreamPlayer3D.playing = false

func _process (delta):
	if (is_on_stove): # check if its in cooking state
		cooking_time += delta # adds time passed since last frame

		if (cooking_time >= max_cooking_time and state != State.COOKED) : # if the time reaches 10 seconds it is cooked
			state = State.COOKED
			_change_patty_color(Color(0.661, 0.379, 0.073, 1.0)) # turn brown
			cooked_printed = true
			Global.patty_cooked += 1
			print("COOKED")

		if cooking_time >= burn_time and state != State.BURNT: # if the time is greater than 20 seocnds the patty state is burnt
			state = State.BURNT
			_change_patty_color(Color(0.069, 0.023, 0.001, 1.0)) # turn black
			burnt_printed = true
			
func _change_patty_color(new_color: Color):
	var mat = $MeshInstance3D.get_active_material(0)
	if mat:
		mat.albedo_color = new_color
