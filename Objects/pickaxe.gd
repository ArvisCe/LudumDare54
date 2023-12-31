extends StaticBody2D

var current_node = null
var health = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_global_mouse_position()
	if Input.is_action_just_pressed("place"):
		if current_node:
			current_node.drop_item()
			current_node.queue_free()
			health -= 1
			get_tree().get_nodes_in_group("Player")[0].using_pickaxe = true
		if health <= 0:
			get_tree().get_nodes_in_group("Player")[0].using_pickaxe = false
			queue_free()
	if Input.is_action_pressed("craft") and health == 2:
		get_tree().get_nodes_in_group("Player")[0].gold += 5
		queue_free()
	pass


func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("entered")
	if area.get_parent().is_in_group("node"):
		current_node = area.get_parent()
	pass
