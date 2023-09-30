extends StaticBody2D

@export var item = preload("res://items/node_item.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func drop_item():
	var dirt = item.instantiate()
	dirt.position = position
	var rng = RandomNumberGenerator.new()
	dirt.position.x += rng.randf_range(-4,4)
	dirt.position.y += rng.randf_range(-4,4)
	dirt.item = get_node("Sprite2D").frame
	var parent = get_parent()
	if parent != null:
		parent.add_child(dirt)
