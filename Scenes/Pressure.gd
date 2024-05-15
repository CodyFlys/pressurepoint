extends Node2D

@onready var depthTimer = $"../ship/Depth"
@onready var player = $"../Player"
var depthRaw = 20.00
var Depth
@onready var depthSprite = $"../Control/Label/counter"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	depthHandler(delta)
	
var tempDepth

func depthHandler(delta):

	if player.isNavigating == true:
		depthRaw += 10 * delta
		var Depth = "%.f" % depthRaw

		if Depth != tempDepth:
			tempDepth = Depth
			depthSprite.text = Depth
			print(Depth)
			if int(Depth) >= 200:
				depthSprite.add_theme_color_override("font_color", Color(255, 0, 0))
		else:
			return
	elif player.isNavigating == false:
		pass
