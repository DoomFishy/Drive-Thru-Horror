extends CharacterBody3D
class_name Player

@export var speed : float = 0
@export var jump_power : float = 0
@export var gravity : float = 9.18

var input_direction : Vector3 = Vector3.ZERO
var direction : Vector3 = Vector3.ZERO
var screen_captured : bool = true

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		update_movement_direction()
		jump()
		
	direction = (transform.basis * Vector3(input_direction.x, 0, input_direction.z)).normalized()
	
func update_movement_direction() -> void:
	input_direction.x = Input.get_action_strength("left") - Input.get_action_strength("right")
	input_direction.z = Input.get_action_strength("up") - Input.get_action_strength("down")

func jump() -> void:
	if Input.is_action_just_pressed("jump"):
		velocity.y = jump_power

# Actual Physical Movements
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	move()
	move_and_slide()

func _process(_delta: float) -> void:
	change_mouse_mode()

func move() -> void:
	if input_direction:
		velocity.x = direction.x * speed * -1
		velocity.z = direction.z * speed * -1
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.25)
		velocity.z = lerp(velocity.z, 0.0, 0.25)

# to escape the dreaded game
func change_mouse_mode() -> void:
	if Input.is_action_just_pressed("ui_cancel"): #escape key
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if Input.is_action_just_pressed("left_mouse"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
