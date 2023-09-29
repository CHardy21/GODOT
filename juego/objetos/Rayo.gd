extends Area2D

export var velocidad = 400.0

var mi_pos = Vector2.ZERO

onready var animacion = $AnimatedSprite


func _ready():
	global_position = mi_pos
	animacion.play("moverse")

func _process(delta):
	global_position.y += velocidad * delta

func _on_body_entered(body):
	if body.is_in_group("Players"):
		body.respawn()
	destruir_rayo()

func _on_screen_exited():
	destruir_rayo()

func destruir_rayo():
	queue_free()

func crear(pos):
	mi_pos = pos
