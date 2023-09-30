extends Control

var player
# Called when the node enters the scene tree for the first time.
var crafting_ui = false

func _ready():
	player = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player != null:
		get_node("Diamond/Label").text = str(player.diamond)
		get_node("Gold/Label").text = str(player.gold)
		get_node("Rock/Label").text = str(player.stone)
		get_node("dynamite/Label").text = str(player.ammo)
	if Input.is_action_just_pressed("craft") and not player.using_pickaxe:
		crafting_ui = !crafting_ui
		craft()
	pass 

func craft():
	get_parent().get_node("Crafting_UI").visible = crafting_ui
	
	


func _on_ladder_pressed():
	if get_tree().get_nodes_in_group("Player")[0].stone >= 6:
		get_tree().get_nodes_in_group("Player")[0].stone -= 6
		var ladder = load("res://Objects/Ladder.tscn").instantiate()
		ladder.z_index = -1
		get_parent().get_parent().add_child(ladder)
		crafting_ui = false
		craft()
		pass # Replace with function body.


func _on_texture_button_pressed():
	if get_tree().get_nodes_in_group("Player")[0].diamond >= 1:
		get_tree().get_nodes_in_group("Player")[0].diamond -= 1
		var dynamite = load("res://Objects/special_dynamite.tscn").instantiate()
		get_parent().get_parent().add_child(dynamite)
		crafting_ui = false
		craft()
	pass # Replace with function body.


func _on_pickaxe_pressed():
	if get_tree().get_nodes_in_group("Player")[0].gold >= 5:
		get_tree().get_nodes_in_group("Player")[0].gold -= 5
		var pickaxe = load("res://Objects/pickaxe.tscn").instantiate()
		get_parent().get_parent().add_child(pickaxe)
		crafting_ui = false
		craft()
	pass # Replace with function body.
