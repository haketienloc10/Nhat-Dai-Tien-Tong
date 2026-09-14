extends SceneTree


func _init() -> void:
	var packed_scene := load("res://scenes/main/main.tscn") as PackedScene
	if packed_scene == null:
		push_error("Không thể load main scene")
		quit(1)
		return

	var instance := packed_scene.instantiate()
	if instance == null:
		push_error("Không thể instantiate main scene")
		quit(1)
		return

	instance.free()
	print("smoke: PASS")
	quit(0)
