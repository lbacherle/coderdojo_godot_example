class_name Slime
extends CharacterBody2D
var direction = 1

const SPEED = 13.0        
const JUMP_VELOCITY = -300.0
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_down_left = $RayCastDownLeft
@onready var ray_cast_down_right = $RayCastDownRight
# Ray cast nach unten????

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	elif ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	elif not ray_cast_down_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	elif not ray_cast_down_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	position.x += direction * SPEED * delta
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			#animated_sprite.play("idle")
			pass
		else:
			animated_sprite.play("run")
			
	else:
		#animated_sprite.play("jump")
		pass
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


	move_and_slide()
