extends StaticBody3D

func interact():
	get_parent().spawn_packaged_burger()
	$AudioStreamPlayer3D.playing = true
