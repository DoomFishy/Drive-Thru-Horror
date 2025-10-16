extends Camera3D

var ray_Range = 2000

func _input(event):
		if event.is_action_pressed("Fire"):
			Get_Camera_Collision()

func Get_Camera_Collision():
	var center = get_viewport().get_size()/2
	
	var ray_Origin = project_ray_origin(center)
	var ray_End = ray_Origin + project_ray_normal(center) * ray_Range
	
	var query = PhysicsRayQueryParameters3D.create(ray_Origin, ray_End)
	query.collide_with_areas = true
	query.collide_with_bodies = true
	query.collision_mask = 1 << 4
	
	var aimRay = get_world_3d().direct_space_state.intersect_ray(query)
	
	if aimRay:
		var collider = aimRay["collider"]
		#print("Hit object:", collider.name, " Type:", collider.get_class(), " Script:", collider.get_script())
		
		if collider and collider.has_method("hit"):
			collider.hit()
			print("Hit: ", collider.name)
		else:
			print("Hit object has no 'hit' method: ", collider)
	else:
		print("Nothing")
