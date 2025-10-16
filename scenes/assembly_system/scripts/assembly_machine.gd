extends Node3D

@export var packagedBurger : PackedScene
var ingredientArray : Array

func add_ingredient(s):
	ingredientArray.append(s)

func _on_item_area_entered(area: Area3D) -> void:
	if area.is_in_group("ingredient"):
		add_ingredient(area)

func spawn_packaged_burger():
	if ingredientArray.size() <= 0:
		return
	$TempLabel.text = ""
	var instance = packagedBurger.instantiate()
	instance.pass_ingredients(ingredientArray)
	add_child(instance)
	instance.position = $BurgerSpawn.position
	
	for i in ingredientArray.size():
		$TempLabel.text += ingredientArray[i].ingredientName + "\n"
		ingredientArray[i].queue_free()
	ingredientArray.clear()
