extends Node3D

@export var camera : Camera3D
@export var bob_frequency = 2.25
@export var bob_amplitude = 0.02
@export var fov_walk : float = 78.0

var player : Player
var bob_time = 0
var sens : float = 0.0025

func _ready():
	player = get_parent()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		player.rotate_y(-event.relative.x * sens)
		rotate_x(-event.relative.y * sens)
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _process(delta: float) -> void:
	bob_time += delta * player.velocity.length() * float(player.is_on_floor())
	camera.transform.origin = head_bob()

func head_bob() -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(bob_time * bob_frequency) * bob_amplitude
	pos.x = cos(bob_time * bob_frequency / 2) * bob_amplitude
	return pos
	
