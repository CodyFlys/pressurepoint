extends CharacterBody2D


const SPEED = 100.0
@onready var animated_sprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("walkLeft", "walkRight")
	
	
	# Flips sprite based on direct
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Handles Switching Animations
	if direction == 0:
		animated_sprite.play("Idle")
	else:
		animated_sprite.play("Walk")
	
	# Moves sprite
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()




#Module Signals


var module = null

func oxygenEnter(_body):
	#print("O Enter")
	module = "oxygen"	
	#if module == "oxygen":
		#print("module Swapped", module)

func oxygenExit(_body):
	#print("O Exit")
	if module == "oxygen":
		module = null
	#if module == null:
		#print("module Swapped", module)

func pressureEnter(_body):
	#print("P Enter")
	module = "pressure"
	#if module == "pressure":
		#print("module Swapped", module)

func pressureExit(_body):
	#print("P Exit")
	if module == "pressure":
		module = null
	#if module == null:
		#print("module Swapped", module)

func navigationEnter(_body):
	#print("N Enter")
	module = "navigation"
	#if module == "navigation":
		#print("module Swapped", module)

func navigationExit(_body):
	#print("N Exit")
	if module == "navigation":
		module = null
	#if module == null:
		#print("module Swapped", module)

func tempEnter(_body):
	#print("T Enter")
	module = "temp"
	#if module == "temp":
		#print("module Swapped", module)

func tempExit(_body):
	#print("T Exit")
	if module == "temp":
		module = null
	#if module == null:
		#print("module Swapped", module)

func elecEnter(_body):
	#print("E Enter")
	module = "elec"
	#if module == "elec":
		#print("module Swapped", module)

func elecExit(_body):
	#print("E Exit")
	if module == "elec":
		module = null
	#if module == null:
		#print("module Swapped", module)

func handleInteraction():
	print('module: ', module)
	
	if module == null:
		print("No Action Too Far")
	
	elif module == "oxygen":
		var o2 = $"../Oxygen"
		o2.reset()
		print("Oxygen Reset")
		
	elif module == "pressure":
		print("pressure")
		
	elif module == "navigation":
		print("navigation")
		
	elif module == "temp":
		print("Temp")
		
	elif module == "elec":
		print("Elec")

func _input(event):
	if module != null:
		if event.is_action_pressed("interact"):
			handleInteraction()
	elif event.is_action_pressed("interact"):
		print("No Action Possible")
