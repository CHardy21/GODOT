extends KinematicBody2D

export var velocidad = 100.0
export var radio_mov_x = 0   #   0 = radio infinito

var gravedad = 100.0
var movimiento = Vector2.ZERO
var posicion_inicial

onready var animacion = $AnimatedSprite
onready var detector_vacio = $DetectorVacio
onready var detector_pared = $DetectorPared


func _ready():
	posicion_inicial = global_transform.origin.x

func _physics_process(_delta):
	caer()
	caminar()
# warning-ignore:return_value_discarded
	move_and_slide(movimiento, Vector2.UP)

func _on_DetectaJugador_body_entered(body):
	body.respawn()

# funcion que detecta el impacto de un proyectil.
func _on_area_entered(_area):
	desactivar_colisionadores([$DetectaJugador/CollisionShape2D, $ColisionPies ])
	morir()


func desactivar_colisionadores(colisionadores):
	for colision in colisionadores:
		colision.set_deferred("disabled", true)
		colision.set_deferred("visible", false)
		# print("se descativo ", colision.name)

func caer():
	if not is_on_floor():
		movimiento.y = gravedad
		
func caminar():
	if not animacion.is_playing():
		animacion.play("caminar")
	detectar_colision()
	movimiento.x = velocidad

func animar(direccion_actual):
	animacion.flip_h = !direccion_actual

func detectar_colision():
	if not detector_vacio.is_colliding() or detector_pared.is_colliding() or limite_movimiento():
		velocidad *= -1
		detector_vacio.position *= -1
		detector_pared.position.x *= -1
		detector_pared.scale *= -1
		animar(animacion.flip_h)

func limite_movimiento():
	if radio_mov_x < 1:
#		print("Amplitud infinita")
		return false
	return position.x > (posicion_inicial + radio_mov_x) or position.x < (posicion_inicial - radio_mov_x)


func morir():
	$AnimationPlayer.play("morir")
	
	

	
