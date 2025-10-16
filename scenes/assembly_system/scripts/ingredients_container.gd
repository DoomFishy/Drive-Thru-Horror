extends StaticBody3D

@export var ingredient : PackedScene

var player: Player
var interactController : Node
var itemHolder : Node3D

func _ready():
	player = get_tree().current_scene.get_node("Player")
	interactController = player.get_node("InteractController")
	itemHolder = player.get_node("head/ItemHolder")
	
func interact():
	if interactController.item == null:
		var instance = ingredient.instantiate()
		instance.position = Vector3.ZERO
		interactController.item = instance
		itemHolder.add_child(instance)
