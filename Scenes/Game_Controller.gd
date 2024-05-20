extends Node2D
@onready var background = $Camera2D/Background
@onready var death = $Control/death
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
@onready var beacon = $beacon
@onready var inside_light = $insideLight
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var bubbles = $Bubbles
@onready var bubbles_2 = $Bubbles2
@onready var lightson = $lightson
@onready var bubbles_audio = $bubblesAudio
@onready var subAudio = $AudioStreamPlayer2D2
var audio_playing = false
var audio_playing_1 = false
@onready var anglerspawner = $anglerspawner
@onready var goldfishspawner = $Goldfishspawner
@onready var deathRect = $Control/death
@onready var deathTag = $Control/death/Label
@onready var record = $Control/record


# Called when the node enters the scene tree for the first time.
func _ready():
	death.visible = false
	Depth = float("%.f" % 20)
	audio_stream_player_2d.play()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Depth >= 200:
		record.visible = false
	
	if subHealth <= 0:
		deathRect.visible = true
		deathTag.text = "Imploded"
	
	modulesStatus = [pressure.pressureOn, electrical.powerOn, temperature.tempSafe]
	implosionHandler(delta)
	depthHandler(delta)
	if player.isNavigating == true:
		if light.energy < 0.70:
			light.energy = light.energy + 0.0001
			flickerLights()
		
		if background.position.y > -1580:
			background.position.y -= 50 * delta
		elif atBottom == false:
			atBottom = true
		else:
			pass
			
	if electrical.powerOn == false and lightsOn == true:
		lightHandler()
		lightsOn = false
		
	if electrical.powerOn == true:
		beacon.enabled = true
		inside_light.visible = true
		if not audio_playing_1:
			subAudio.play()
			audio_playing_1 = true
	else:
		beacon.enabled = false
		inside_light.visible = false
		
	if int(Depth) >= 200:
		anglerspawner.emitting = true
		goldfishspawner.emitting = false

func flickerLights():
	if electrical.powerOn == true:
		if int(Depth) >= 200 and lightsOn == false:
			lightsOn = true
			lightson.play()
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
		
		if not audio_playing:
			bubbles.emitting = true
			bubbles_2.emitting = true
			bubbles_audio.play()
			audio_playing = true

		if Depth != tempDepth:
			tempDepth = Depth
			depthSprite.text = "%.f" % Depth
			if int(Depth) >= 300:
				depthSprite.add_theme_color_override("font_color", Color(255, 0, 0))
				pass
		else:
			return
	elif player.isNavigating == false:
		bubbles.emitting = false
		bubbles_2.emitting = false
		bubbles_audio.stop()










# Sub bullshit
@onready var pressure = $Pressure
@onready var oxygen = $Oxygen
@onready var temperature = $Temperature
var subHealth = 50
@onready var modulesStatus = [pressure.pressureOn, electrical.powerOn, temperature.tempSafe]
var dangerDepth = 100
@onready var window = $ship/ship/window

func implosionHandler(delta):
	if Depth >= dangerDepth:
		if subHealth >= 0:
			var subDrain = 0
			for status in modulesStatus:
				if!status:
					subDrain += 1
					subHealth -= subDrain * 2 * delta
		elif subHealth <= 0:
			#call death
			pass
	if subHealth > 40:
		window.play("Normal")
	elif subHealth <= 40 and subHealth > 30:
		window.play("crack_1")
	elif subHealth <= 30 and subHealth > 15:
		window.play("crack_2")
	elif subHealth <= 15:
		window.play("crack_3")
	
