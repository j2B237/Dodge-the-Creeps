extends Node


export(PackedScene) var mob_scene
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func game_over():
	$Music.stop()
	$DeathSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	
	
func new_game():
	$Music.play()
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$Player.start($startPosition.position)
	$Player.show()
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_MobTimer_timeout():
	# Choose random location on Path2D
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()
	
	# Create a mob instance and add it to the scene
	var mob = mob_scene.instance()
	add_child(mob)
	
	# Set the mob direction perpendicular to the path direction
	var direction = mob_spawn_location.rotation + PI / 2
	
	# Set the mob position to a random position
	mob.position = mob_spawn_location.position
	
	# Add some randomness to direction
	direction += rand_range(PI/4, PI/4)
	mob.rotation = direction
	
	# Choose the velocity
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
