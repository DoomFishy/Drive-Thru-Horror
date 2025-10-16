extends Area3D

var ingredients_number : Array
var ingredients : Array

func pass_ingredients(a : Array, num : Array):
	ingredients_number = num.duplicate()
	ingredients = a.duplicate()

func get_ingredients() -> Array:
	return ingredients_number
