extends CanvasLayer

# Indicate to the main scene that start btn is pressed
signal start_game
signal timeout

# Called when the node enters the scene tree for the first time.
func _ready():
	#var btn = get_node("StartButton")
	#btn.connect("pressed", self, "_on_StartButton_pressed")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show_message(text):
	# Call only when we want to display a message
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")
	# Wait until message timer has count down
	yield($MessageTimer,"timeout")
	
	$ScoreLabel.text = "0"
	$Message.text = "Dodge the \nCreeps"
	$Message.show()
	# make a one-shot timer and wait for it to finish
	yield(get_tree().create_timer(1.0), "timeout") 
	$StartButton.show()
	
	
func update_score(score):
	$ScoreLabel.text = str(score)
	

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
	
	
func _on_MessageTimer_timeout():
	$Message.hide()
