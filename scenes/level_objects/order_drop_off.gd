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
	print("CURRENT: ", current_index)

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
	for i in order_count:
		print(i)
		
	if burger:
		print(burger.ingredients_number)
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

	for i in submission_count:
		print(i)

func check_submission():
	var j : int = 0
	var patty : int = submission_count[3]
	for i in order_count.size():
		if submission_count[i] == order_count[i]:
			print("CORRECT: ", i)
			submission_count[i] = 0
			order_count[i] = 0
			j += 1
		else:
			print("WRONG: ", i)
	
	print(j, order_count.size(), has_top, has_bot, Global.patty_cooked, submission_count[3])


	if j == order_count.size() and has_bot and has_top and Global.patty_cooked == patty:
		Global.order_started = false
		Global.score += 1
		Global.submission[0] += 1
		print("CORRECT")
	else:
		print("WRONG")
		Global.order_started = false
		Global.score -= 1
		if Global.order_people[Global.people_index] == 0:
			Global.score -= 2
			Global.submission[2] += 1
		else:
			Global.submission[1] += 1
	
	has_bot = false
	has_top = false
	Global.patty_cooked = 0
	Global.people_index += 1

func _on_area_entered(area: Area3D) -> void:
	if not (area.is_in_group("ingredients") or area.is_in_group("patty") or area.is_in_group("gun")):
		submit_order(area)
		check_submission()
		area.queue_free()
		car.exit()
		$AudioStreamPlayer3D.playing = true
	
