extends Node2D

@export var target_postion = Vector2(0, 13.00)  # Set your target Y position here
@onready var oxgen_sprite = $StaticBody2D/CollisionShape2D/AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
@onready var water = $StaticBody2D/CollisionShape2D/AnimatedSprite2D/Water
@onready var t = create_tween()
#@onready var oxygenLevel = 100.00
@onready var machineRunTime = 10
var blueValue = 10
@onready var player = $"../Player"
var hasOxygen = true
var timeUntilDead = 100;
var timeWithoutOxygen = 0.00;
var battery = 2

func _ready():
	t.tween_property(water, "position", target_postion, machineRunTime) 
	t.connect("finished", self.finished, 1)
	pass

func finished():
	oxgen_sprite.play("Off")
	
func _process(delta):
	var moduleUpTime = int(t.get_total_elapsed_time())

	# Calculate the elapsed time since the start of the tween relative to machineRunTime
	var oxygenLeft = machineRunTime - moduleUpTime

	# Use lerp to gradually decrease oxygen to 0 over the elapsed time
	if oxygenLeft <= 0:
		hasOxygen = false
		timeWithoutOxygen += 0.001 * delta
		
	print('oxygenLeft', oxygenLeft)
	if oxygenLeft > machineRunTime / 2:
		oxgen_sprite.play("On")
		
	if oxygenLeft <= machineRunTime / 2:
		print('50% power! switching sprite')
		oxgen_sprite.play("On_50")
		
	if not hasOxygen:
		if(timeWithoutOxygen <= 0.006):
			player.modulate.b += timeWithoutOxygen
			oxgen_sprite.play("Off")
