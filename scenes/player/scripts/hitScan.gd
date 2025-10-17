extends Camera3D

var ray_Range = 2000
var has_gun = false

@export var period = 0.3
@export var magnitude = 0.4

func _input(event):
		if event.is_action_pressed("Fire") and has_gun:
			Get_Camera_Collision()
			_camera_shake()
			$"../../AudioStreamPlayer2".playing = true

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


func _camera_shake():
	var initial_transform = get_parent().transform 
	var elapsed_time = 0.0

	while elapsed_time < period:
		var offset = Vector3(
			randf_range(-magnitude, magnitude),
			randf_range(-magnitude, magnitude),
			0.0
		)

		get_parent().transform.origin = initial_transform.origin + offset
		elapsed_time += get_process_delta_time()
		await get_tree().process_frame

	get_parent().transform = initial_transform
