extends Node2D

@export var target_postion = Vector2(0, 13.00)  # Set your target Y position here
@onready var oxgen_sprite = $StaticBody2D/CollisionShape2D/AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
@onready var water = $StaticBody2D/CollisionShape2D/AnimatedSprite2D/Water
@onready var t = create_tween()
#@onready var oxygenLevel = 100.00
@onready var machineRunTime = 120
#@onready var powerOn = powerOn
var blueValue = 10
@onready var player = $"../Player"
var hasOxygen = true
var timeUntilDead = 100;
var timeWithoutOxygen = 0.00;
var battery = 2
var called = false # Works as a switch for the oxygen 50% check (quick fix)
var powerOn = false
@onready var oxygenCount = $"../Control/oxygen_label/Label"
@onready var electrical = $"../Electrical"
var last_time
var count = 0
@onready var oxygenLeft = machineRunTime

func _ready():
	last_time = Time.get_ticks_msec()
	oxygenCount.text = "%.f" % machineRunTime
	var electrical = $"../Electrical"
	pass

func finished():
	oxgen_sprite.play("Off")
	
func _process(delta):
		
	powerOn = electrical.powerOn
	#print(powerOn, 'powwer?')
	var moduleUpTime = int(t.get_total_elapsed_time())
	
	if powerOn and count <= machineRunTime:
		# Get the current time in milliseconds
		var current_time = Time.get_ticks_msec()
		
		# Check if 1000 milliseconds (1 second) have passed
		if current_time - last_time >= 1000:
			# Increment the count
			count = count + 1
			# Print the current count
			print(count)
			# Update last_time to the current time
			last_time = current_time
			
			if count >= machineRunTime and not hasOxygen:
				water.visible = false
				hasOxygen = false
				
		# Calculate the elapsed time since the start of the tween relative to machineRunTime
		oxygenLeft = machineRunTime - count
		if oxygenLeft:
			oxygenCount.text = "%.f" % oxygenLeft

	# Use lerp to gradually decrease oxygen to 0 over the elapsed time
	if oxygenLeft <= 0:
		hasOxygen = false
		water.visible = false
		timeWithoutOxygen += 0.001 * delta
		oxygenCount.text = "%.f" % 0
		
	#print('oxygenLeft', oxygenLeft)
	if oxygenLeft > float(float(machineRunTime) / float(2)):
		if powerOn:
			oxgen_sprite.play("On")
		
	if oxygenLeft <= float(float(machineRunTime) / float(2)):
		if powerOn:
			if called == false: # Checks if hasnt be called, runs, then sets called to true
				#print('50% power! switching sprite')
				oxgen_sprite.play("On_50")
				called = true
			elif called == true: # Passes fuction if it has been called before
				pass

		
	if not hasOxygen or not powerOn:
		if(timeWithoutOxygen <= 0.006):
			player.modulate.b += timeWithoutOxygen
			oxgen_sprite.play("Off")

func reset():
	if powerOn:
		water.visible = true
		hasOxygen = true
		count = 0
