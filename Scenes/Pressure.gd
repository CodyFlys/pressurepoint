extends Node2D

@onready var depthTimer = $"../ship/Depth"
@onready var player = $"../Player"
@onready var game = $".."
@onready var pressure = $StaticBody2D/CollisionShape2D/AnimatedSprite2D

var health = 100.00


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if game.Depth != null:
		var depth = game.Depth
		pressureDrain(_delta, depth)
		pass
	

func pressureDrain(_delta, depth):
	var drain = float(depth) / 100000.00
	if health > 0:
		health -= drain
		if health >= 95:
			pressure.play("4_4")
		if health <= 75 and health > 50:
			pressure.play("3_4")
		if health <= 50 and health > 25:
			pressure.play("2_4")
		if health <= 25 and health > 0:
			pressure.play("1_4")
		if health <= 0:
			pressure.play("0_4")
		
		
		print(health)
	pass
