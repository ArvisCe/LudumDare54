extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = str(calculate_score())
	pass


func calculate_score():
	var player = get_parent().get_parent()
	var stone = player.stone
	var gold = player.gold
	var diamond = player.diamond
	return (stone)+(gold*3)+(diamond*5)
