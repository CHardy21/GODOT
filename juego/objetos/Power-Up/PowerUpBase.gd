extends Area2D

onready var animacion = $AnimationPlayer
onready var detectar_jugador = $CollisionShape2D


#func _ready():
#	print("Hola Mundo, soy ",self.name)


func _on_body_entered(body):
	aplicar_power_up(body)
	detectar_jugador.set_deferred("disabled", true)
	animacion.play("consumir")


func aplicar_power_up(body):
	pass
