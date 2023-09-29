extends Area2D

export(String, "oro", "plata", "bronce") var tipo_moneda

onready var anamacion := $AnimatedSprite
onready var animacion_consumir := $AnimationPlayer
onready var colision_personaje := $ColisionPersonaje

# Called when the node enters the scene tree for the first time.
func _ready():
	anamacion.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_body_entered(_body):
	DatosPlayers.sumar_monedas(tipo_moneda)
	colision_personaje.set_deferred("disabled", true)
	animacion_consumir.play("consumir")
