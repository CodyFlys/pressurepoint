extends Node2D


var health := 100.000
var degrade := 00.001
var yDisplace := 0.12
var secondsDegrade := 30 # Time to deplete, = S

var perSecond = 100/secondsDegrade # 100/S = Y
var autoDegrade = perSecond/100 # Y/100 = X, and X = our degrade



# Called when the node enters the scene tree for the first time.

var spriteOrigin
var temp
@onready var sprite_2d = $Sprite2D


func _ready():
	#var spriteOrigin = $Sprite2D.y
	temp = 0
	pass # Replace with function body.

func _time():
	health = health - .001
	

	
	if temp >= 1:
		print("Temp Hit One")
		
		#sprite_2d.y - yDisplace
		
		#sprite_2d.y - 0.12
		temp = 0
	else:
		temp = temp + degrade
	
	var clean = "%.3f" % health
	
	if clean is int:
		print("Health Int")
		
	print("Health:", clean, "Temp:", temp)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_time()
