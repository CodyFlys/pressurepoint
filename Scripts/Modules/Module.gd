extends Node2D

@export var target_postion = Vector2(0, 12.00)  # Set your target Y position here
var duration = float(30000)  # Duration in seconds
var current_time = 0.0
var timer_running = true

# Called when the node enters the scene tree for the first time.
var spriteOrigin
var temp
@onready var water = $Oxygen/StaticBody2D/CollisionShape2D/AnimatedSprite2D/Water

func _ready():
	var t = create_tween()
	t.tween_property(water, "position", target_postion, 30) 
	pass

func _process(delta):
	pass
