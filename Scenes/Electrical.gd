extends Node2D

@export var powerOn = true
@onready var game = $".."
@onready var powerBox = $StaticBody2D/CollisionShape2D/AnimatedSprite2D
var rng = RandomNumberGenerator.new()
var degradedMax = 120
var healthReset = rng.randf_range(40,degradedMax)
var health
var Depth = 20
var lightsDrain = false
var drain = 20.00 / 100000.00

# Called when the node enters the scene tree for the first time.
func _ready():
	health = healthReset
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if game.Depth != null:
		Depth = game.Depth
		pressureDrain(_delta, Depth)
	pass

func pressureDrain(_delta, Depth):
	
	print(health)
	#print("Health: ", health, "Drain:", drain)
	if game.lightsOn == true:
		drain = (float(Depth) / 100000.00) + 0.005
		lightsDrain = true
		
		if health > 0:
			powerBox.play("Stable")
			health -= drain
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
	pass
