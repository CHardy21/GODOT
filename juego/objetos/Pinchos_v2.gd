extends KinematicBody2D

export var es_trampa = false
export var color_trampa = Color.brown

var movimiento = Vector2.ZERO
var velocidad = Vector2(400.0,900.0)
var caida = false

onready var detector_personaje = $DetectorPersonaje
onready var detector_colision = $DetectorColision/Colisionador


func _ready():
	if es_trampa:
		$Sprite.modulate = color_trampa
		detector_personaje.enabled = true
		detector_colision.set_deferred("enabled", false)
		

func _process(_delta):
	if detector_personaje.is_colliding():
		detector_personaje.set_deferred("enabled",false)
		detector_colision.set_deferred("enabled", true)
		$AnimationPlayer.play("caer")
		
	if caida:
		movimiento.y = velocidad.y
		move_and_slide(movimiento, Vector2.UP)

func _on_DetectorColision_body_entered(body):
	print("entro ",body.name)
	if body.is_in_group("Players"):
		body.respawn()
	caida = false
	$AnimationPlayer.play("destruirse")

func caer():
	caida = true




	
