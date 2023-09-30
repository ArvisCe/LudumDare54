extends StaticBody2D

var exploded = false
var nodes = []
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(0.9).timeout
	queue_free()
	pass # Replace with function body.

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.get_parent().is_in_group("node"):
		area.get_parent().drop_item()
		area.get_parent().queue_free()
	pass # Replace with function body.

