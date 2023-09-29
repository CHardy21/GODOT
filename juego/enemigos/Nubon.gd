extends Node2D

export var rayo: PackedScene

var puede_disparar = true

onready var detector_jugador = $Sprite/RayCast2D
onready var posiciones_disparo = $Sprite/PosicionesDisparo
onready var cadencia_disparo = $Timer
onready var sfx_rayos =  $DisparoRayos


func _process(_delta):
	if detector_jugador.is_colliding() and puede_disparar:
		#print("Nubon vio al Jugador")
		disparar()
		puede_disparar = false
		cadencia_disparo.start()


func disparar():
	sfx_rayos.play()
	for posicion in posiciones_disparo.get_children():
		var nuevo_rayo = rayo.instance()
		nuevo_rayo.crear(posicion.global_position)
		owner.get_node("Rayos").add_child(nuevo_rayo)


func _on_Timer_timeout():
	puede_disparar = true
