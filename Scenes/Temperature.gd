extends Node2D

@onready var game = $".."
var startingTemp = 80
var dangerTemp = 50
var temp = startingTemp
@onready var electrical = $"../Electrical"
@onready var counterDisplay = $"../Control/tempLabel/counter"
var tempSafe = true


func _ready():
	counterDisplay.text = "%.f" % temp
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if temp <= 50:
		tempSafe = false
		counterDisplay.add_theme_color_override("font_color", Color(255, 0, 0))
	elif temp > 50:
		tempSafe = true
	
	if game.Depth != null:
		var depth = game.Depth
		if depth >= 100:
			tempDrain(depth, delta)
			pass
func tempDrain(depth, delta):
	var drain = float(depth) / 10000.00
	if electrical.powerOn == true:
		temp -= drain * delta
		counterDisplay.text = "%.f" % temp
		
	elif electrical.powerOn == false:
		drain = float(depth) / 1000.00
		temp -= drain * delta
		counterDisplay.text = "%.f" % temp
		
func reset():
	temp = startingTemp
	counterDisplay.text = "%.f" % temp
