extends CharacterBody2D


@export var speed : float = 200.0
@export var jump_velocity : float = -250.
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
const wall_jump_pushback = 500

# const jump_power = -800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta
	jump()

	# Handle Jump.
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	
	move_and_slide()
	update_animation()
	update_facing_direction()
	
func update_animation():
	if not animation_locked:
		if direction.x != 0:
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")

func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = true
	elif direction.x < 0:
		animated_sprite.flip_h = false
		

func jump():
	
	if Input.is_action_just_pressed("jump"):
		animated_sprite.play("jump")
		animation_locked = true
		if is_on_floor():
			velocity.y = jump_velocity
		if is_on_wall() and Input.is_action_pressed("right"):
			velocity.y = jump_velocity
			velocity.x = -wall_jump_pushback
		if is_on_wall() and Input.is_action_pressed("left"):
			velocity.y = jump_velocity
			velocity.x = wall_jump_pushback
			
	


func _on_animated_sprite_2d_animation_finished():
	if(animated_sprite.animation == "jump"):
		animation_locked = false
