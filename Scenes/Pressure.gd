extends Node2D

@onready var depthTimer = $"../ship/Depth"
@onready var player = $"../Player"
var depthRaw = 20.00
var Depth

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	depthHandler(delta)
	
var tempDepth

func depthHandler(delta):

	if player.isNavigating == true:
		depthRaw += 5 * delta
		var Depth = "%.f" % depthRaw

		if Depth != tempDepth:
			tempDepth = Depth
			print(Depth)
		else:
			return
	elif player.isNavigating == false:
		pass
