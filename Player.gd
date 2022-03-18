extends Area2D

# Define personalized signal
signal hit

export var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Player's movement vector
	# By default the player won't move
	var velocity = Vector2.ZERO
	
	# Get player inputs
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		
	
	# Limit the speed of sprite on movement then animated sprite
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	# Change sprite animation depending on direction
	if velocity.x != 0 :
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.flip_v = velocity.y > 0
		
	# Get the player move with certain speed
	position += velocity * delta
	
	# Limit player position to the screen size
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	


func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
	
	
func start(pos):
	$AnimatedSprite.animation = "walk"
	if $AnimatedSprite.flip_v == true:
		$AnimatedSprite.flip_v = false
		
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
