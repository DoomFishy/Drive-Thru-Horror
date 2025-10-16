extends Area3D

@export var button : StaticBody3D
@export var car : Node3D

var orders_dict
var orders_array : Array

var order_keys = []    # list of customer keys
var current_index = 0  # where we left off

# in-order: Onions, tomatos, lettuce, patty
var order_count = [0,0,0,0]
var submission_count = [0,0,0,0]
var has_bot = false
var has_top = false

func _ready() -> void:
	orders_dict = button.orders
	order_keys = orders_dict.keys()

func submit_order(burger: Area3D):
	if current_index >= order_keys.size():
		return
	
	var key = order_keys[current_index]
	var z = orders_dict[key]
		
	for topping in z:
		match(topping):
			"onion":
				order_count[0] = z[topping]
			"tomato":
				order_count[1] = z[topping]
			"lettuce":
				order_count[2] = z[topping]
			"patty":
				order_count[3] = z[topping]
	current_index += 1
	
	if burger.ingredients_number:
		for i in burger.ingredients_number:
			match(i):
				"onion":
					submission_count[0] += 1
				"tomato":
					submission_count[1] += 1
				"lettuce":
					submission_count[2] += 1
				"patty":
					submission_count[3] += 1
				"bottom":
					has_bot = true
				"top":
					has_top = true

func check_submission():
	var j : int = 0
	for i in order_count.size():
		if submission_count[i] == order_count[i]:
			j += 1

	if j == order_count.size() and has_bot and has_top and Global.patty_cooked == submission_count[3]:
		Global.order_started = false
		print("YEP")
	else:
		Global.order_started = false
		print("WRONG")
	
	has_bot = false
	has_top = false
	Global.patty_cooked = 0

func _on_area_entered(area: Area3D) -> void:
	submit_order(area)
	check_submission()
	area.queue_free()
	car.exit()
	
