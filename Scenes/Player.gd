extends CharacterBody2D


const SPEED = 100.0
@onready var animated_sprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var isNavigating = false
@export var isInteracting = false
@onready var pressure = $"../Pressure"
@onready var electrical = $"../Electrical"
@onready var game = $".."

func _physics_process(delta):
	# Add the gravity.
	
	if isNavigating == true and electrical.powerOn == false:
		isNavigating = false
	
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("walkLeft", "walkRight")
	
	# Flips sprite based on direct
	if isNavigating == false and isInteracting == false:
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
		
		# Handles Switching Animations
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Walk")
		
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
	if module == "elec":
		#print("module Swapped", module)
		pass

func elecExit(_body):
	#print("E Exit")
	if module == "elec":
		module = null
	#if module == null:
		#print("module Swapped", module)
@onready var temperature = $"../Temperature"
func handleInteraction(event):
	print('module: ', module)
	
	if module == null:
		print("No Action Too Far")
	
	elif module == "oxygen":
		var o2 = $"../Oxygen"
		o2.reset()
		print("Oxygen Reset")
		
	elif module == "pressure":
		if event.is_action_pressed("interact"):
			pressure.health = 100
			print("pressure")
		
	elif module == "navigation":
		if electrical.powerOn == true:
			isNavigating = true
			print("Is Navigating, power is on")
		
	elif module == "temp":
		temperature.reset()
		print("Temp")
		
	elif module == "elec":
		electrical.powerOn = true
		electrical.health = electrical.healthReset
		game.flickerLights()
		print("Electical flipped!")

func _input(event):
	if module != null:
		if isNavigating == false and event.is_action_pressed("interact"):
			handleInteraction(event)
		elif isNavigating == true and event.is_action_pressed("interact"):
			isNavigating = false
			print("Stopped Navigating")
			
	elif event.is_action_pressed("interact"):
		print("No Action Possible")
