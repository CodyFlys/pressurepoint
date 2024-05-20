extends Node2D

var powerOn = false
@onready var game = $".."
@onready var powerBox = $StaticBody2D/CollisionShape2D/AnimatedSprite2D
var rng = RandomNumberGenerator.new()
var degradedMax = 120
#var healthReset = rng.randf_range(40,degradedMax)
var healthReset = 120;
var health = 120
var hasStarted = false;
var depth = 20
var lightsDrain = false
var drain = 20.00 / 100000.00
@onready var powerPercent = $"../Control/power_label/Label"

# Called when the node enters the scene tree for the first time.
func _ready():
	powerPercent.text = "%.f" % health
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print("Health: ", health, "Drain:", drain)
	
	if game.Depth != null:
		depth = game.Depth
		hasStarted = true
		if depth >= 100:
			pressureDrain(_delta, depth)
	pass

func pressureDrain(_delta, Depth):
	#print("Health: ", health, "Drain:", drain)
	if game.lightsOn == true:
		drain = (float(Depth) / 100000.00) + 0.005
		lightsDrain = true
		
		if health > 0:
			powerBox.play("Stable")
			health -= drain
			powerOn = true
		if health <= 0:
			powerBox.play("broken")
			powerOn = false
	elif game.lightsOn == false and lightsDrain == false:
		drain = float(Depth) / 100000.00

		if health > 0:
			powerBox.play("Stable")
			health -= drain
		if health <= 0:
			powerBox.play("broken")
			powerOn = false
	
	powerPercent.text = "%.f" % health
	pass
