extends Node

@export var raycast : RayCast3D
@export var itemHolder : Node3D

var player : Player
var item = null

func _ready() -> void:
	player = get_parent() # get reference to player

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"): # check if press E
		if raycast.is_colliding(): # check if colliding to valid object
			var collider = raycast.get_collider() # get object
			if collider.collision_layer == 2 and item != null: # check if wanting to drop item
				drop_item()
				item = null
			elif collider.collision_layer == 4 and item == null: # check if wanting to pickup item
				item = raycast.get_collider()
				pickup_item()
				if item.is_in_group("gun"):
					raycast.get_parent().has_gun = true
					
			elif collider.collision_layer == 8:
				collider.interact() # call method interact from collider object
				pass

func pickup_item() -> void:
	item.get_parent().remove_child(item) # remove item from world
	itemHolder.add_child(item) # add item to hand
	item.position = Vector3.ZERO # reset item position
	

func drop_item() -> void:
	itemHolder.remove_child(item) # remove item from hand
	player.get_parent().add_child(item) # add item to world
	item.position = raycast.get_collision_point() # set position of item to crosshair
	if item.is_in_group("gun"):
		raycast.get_parent().has_gun = false
