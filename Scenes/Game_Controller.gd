extends Node2D
@onready var background = $Background

@onready var light = $DirectionalLight2D
@onready var lightLevel = light.energy;
@onready var outLight1 = $ship/outsideLight
@onready var outLight2 = $ship/outsideLight2
var lightsOn = false
var atBottom = false
@onready var player = $Player
var depthRaw = 20.00
@export var Depth = 20
@onready var depthSprite = $Control/Label/counter
var tempDepth
var current_font_color = Color(0, 0, 255)
@onready var electrical = $Electrical



# Called when the node enters the scene tree for the first time.
func _ready():
	Depth = float("%.f" % 20)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	depthHandler(delta)
	if player.isNavigating == true:
		if light.energy < 0.70:
			light.energy = light.energy + 0.0001
			flickerLights()
		else:
			pass
		
		if background.position.y > -1580:
			background.position.y -= 50 * delta
		elif atBottom == false:
			print("Bottom Reached")
			atBottom = true
		else:
			pass
			
	if electrical.powerOn == false and lightsOn == true:
		print("called")
		lightHandler()
		lightsOn = false

func flickerLights():
	if electrical.powerOn == true:
		if int(Depth) >= 100 and lightsOn == false:
			lightsOn = true
			lightHandler()
			await get_tree().create_timer(0.12).timeout
			lightHandler()
			await get_tree().create_timer(0.12).timeout
			lightHandler()
			await get_tree().create_timer(0.1).timeout
			lightHandler()
			await get_tree().create_timer(0.12).timeout
			lightHandler()

func flickerLightsDebug():
	if lightsOn == false:
		lightsOn = true
		lightHandler()
		await get_tree().create_timer(0.12).timeout
		lightHandler()
		await get_tree().create_timer(0.12).timeout
		lightHandler()
		await get_tree().create_timer(0.1).timeout
		lightHandler()
		await get_tree().create_timer(0.12).timeout
		lightHandler()

func lightHandler():
	outLight1.visible = !outLight1.visible
	outLight2.visible = !outLight2.visible

func depthHandler(delta):

	if player.isNavigating == true:
		depthRaw += 10 * delta
		Depth = float("%.f" % depthRaw)

		if Depth != tempDepth:
			tempDepth = Depth
			depthSprite.text = "%.f" % Depth
			if int(Depth) >= 300:
				depthSprite.add_theme_color_override("font_color", Color(255, 0, 0))
				pass
		else:
			return
	elif player.isNavigating == false:
		pass
