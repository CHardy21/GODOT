extends Area2D

onready var detector_jugador = $DetectorJugador
onready var detector_pisoton = $DetectorPisoton/Colisionador
onready var animacion = $AnimationPlayer


func _on_DetectorPisoton_body_entered(body):
	## get_tree().paused = true   ## para pausar la ejecucion en este punto...
	# print(body.name, " recibio impulso...")
	
	desactivar_colisionadores([detector_jugador,detector_pisoton])
	animacion.stop()
	animacion.play("morir")
	body.impulsar()

func _on_body_entered(body):
	body.respawn()

func _on_Proyectil_area_entered(_area):
	desactivar_colisionadores([detector_jugador,detector_pisoton])
	morir()


func desactivar_colisionadores(colisionadores):
	for colision in colisionadores:
		colision.set_deferred("disabled", true)
		colision.set_deferred("visible", false)
		# print("se descativo ", colision.name)

func morir():
	$AnimationPlayer.play("morir")
