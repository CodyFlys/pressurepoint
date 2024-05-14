extends Node2D
@onready var background = $Background

@onready var light = $DirectionalLight2D
@onready var lightLevel = light.energy;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	background.position.y -= 50 * delta
	light.energy = light.energy + 0.00001
