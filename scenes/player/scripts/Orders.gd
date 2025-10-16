extends Node
# in-order: Onions, tomatos, lettuce, patty
var orders = { 
	"customer1": {"onion": 1, "tomato": 1}, #human
	"customer2": {"tomato": 1, "lettuce": 1}, #human
	"customer3": {"fetus": 1}, #monster
	"customer4": {}, #monster
	"customer5": {"onion": 2, "tomato": 2, "lettuce": 1}, #human
	"customer6": {
		"frwise": 99, 
		"burger": 99, 
		"pizza": 99, 
		"pie": 99, 
		"chimken nuggets": 99, 
		"taco": 99
	}, #homeless person
	"customer7": {"onion": 4, "tomato": 1, "patty": 3}, #human
	"customer8": {}, #monster
}

@onready var label = $"../Monitor/Label3D"

var order_keys = []    # list of customer keys
var current_index = 0  # where we left off

func _ready():
	order_keys = orders.keys()  # store the keys for indexed access
				# clear any previous text

func interact():
	label.text = "" 
	if current_index >= order_keys.size():
		label.text = "All orders shown!"
		return
	
	var key = order_keys[current_index]
	var z = orders[key]
	
	label.text += str(key) + ":\n"
	
	for topping in z:
		label.text += "  " + str(topping) + ": " + str(z[topping]) + "\n"
	
	label.text += "\n"
	current_index += 1
