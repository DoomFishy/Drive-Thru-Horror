extends Node
# in-order: Onions, tomatos, lettuce, patty


var orders = { 
	"customer1": {"onion": 1, "tomato": 1, "patty": 1}, #human
	"customer2": {"tomato": 1, "lettuce": 1, "patty": 2}, #human
	"customer3": {"fetus": 1}, #monster
	"customer4": {"onion": 1, "tomato": 2, "lettuce": 2, "patty": 2}, #monster
	"customer5": {"onion": 2, "tomato": 2, "lettuce": 1, "patty": 1}, #human
	"customer6": {
		"frwise": 99, 
		"burger": 99, 
		"pizza": 99, 
		"pie": 99, 
		"chimken nuggets": 99, 
		"taco": 99
	}, #homeless person
	"customer7": {"onion": 4, "tomato": 1, "patty": 3}, #human
	"customer8": {"Your Eyes": 1}, #monster
}

@onready var label = $"../Monitor/Label3D"
@export var car : Node3D

var order_keys = []    # list of customer keys
var current_index = 0  # where we left off

func _ready():
	order_keys = orders.keys()  # store the keys for indexed access

func interact():
	car.arrive()
	if Global.order_started == false:
		print("CURRENT: ", current_index)

		Global.order_started = true
		label.text = "" 
		if current_index >= order_keys.size():
			$"../WindowAnim".play("fade")
			$"../ColorRect".visible = true
			await get_tree().create_timer(1).timeout
			get_tree().change_scene_to_file("res://scenes/levels/end.tscn")
			return
		
		var key = order_keys[current_index]
		var z = orders[key]
		
		label.text += str(key) + ":\n"
		
		for topping in z:
			label.text += "  " + str(topping) + ": " + str(z[topping]) + "\n"
		
		label.text += "\n"
		current_index += 1
