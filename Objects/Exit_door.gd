extends StaticBody2D


# Called when the node enters the scene tree for the first time.
var applicable = false
func _ready():
	$Leave_text.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		if applicable:
			$Leave_text.visible = true
	pass # Replace with function body.
	
func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		$Leave_text.visible = false
		applicable = true
	pass # Replace with function body.
