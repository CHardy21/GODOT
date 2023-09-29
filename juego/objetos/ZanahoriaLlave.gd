extends Area2D

signal consumir_llave()  ## 1. Declaramos la señal personalizada


func _ready():
	pass


func _on_body_entered(_body):
	DatosPlayers.restar_llaves()
	emit_signal("consumir_llave")  ## 2. emitir la señal Personalizada
	$DetectorPersonaje.set_deferred("disabled",true)
	$AnimationPlayer.play("consumir")
