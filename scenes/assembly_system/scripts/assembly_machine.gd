extends Node3D

@export var packagedBurger : PackedScene
var ingredientArray : Array
var ingredientArrayName : Array
var is_pressed : bool = false

func add_ingredient(s):
	ingredientArray.append(s)
	ingredientArrayName.append(s.ingredientName)
	
func remove_ingredient(s):
	ingredientArray.erase(s)
	ingredientArrayName.erase(s.ingredientName)

func _on_item_area_entered(area: Area3D) -> void:
	if area.is_in_group("ingredient"):
		add_ingredient(area)

func _on_ingredient_detector_area_exited(area: Area3D) -> void:
	if area.is_in_group("ingredient") and not is_pressed:
		remove_ingredient(area)

func spawn_packaged_burger():
	is_pressed = true
	if ingredientArray.size() <= 0:
		return
	var instance = packagedBurger.instantiate()
	add_child(instance)
	instance.pass_ingredients(ingredientArray, ingredientArrayName)
	instance.position = $BurgerSpawn.position

	for i in ingredientArray.size():
		ingredientArray[i].queue_free()
	ingredientArray.clear()
	ingredientArrayName.clear()
	is_pressed = false
