extends KinematicBody2D

export var velocidad = Vector2(400.0,400.0)
export var acel_caida = 400
export var fuerza_salto = 3000
export var fuerza_rebote = 350
export var impulso = -3800
export var proyectil: PackedScene

var movimiento = Vector2.ZERO
var fuerza_salto_original
var acel_caida_original
var puede_moverse = true
var puede_disparar = true


onready var audio_salto = $AudioSaltar
onready var camara = $Camera2D
onready var enfriamiento_power_up = $EnfriamientoPowerUpSalto
onready var enfriamiento_power_up_volar = $EnfriamientoPowerUpVolar
onready var enfriamiento_disparo = $EnfriamientoDisparo
onready var animacion_personaje = $AnimationPlayer
onready var player_selected = DatosPlayers.player_selected
#onready var animacion = ""
onready var animacion = $AnimatedSprite


func _ready():
	if player_selected == "player2":
		animacion = $AnimatedSprite2
		$AnimatedSprite.queue_free()
	else:
		animacion = $AnimatedSprite
		$AnimatedSprite2.queue_free()
	
	animacion_personaje.play("aclarar")
	fuerza_salto_original = fuerza_salto
	acel_caida_original = acel_caida

func _physics_process(_delta):
	movimiento.x = velocidad.x * tomar_direccion()
	caer()
	saltar()
	colision_techo()
	caida_al_vacio()
# warning-ignore:return_value_discarded
	move_and_slide(movimiento, Vector2.UP)

func _input(event):
	if event.is_action_pressed("shoot"):
		shoot_ctrl()


func _on_EnfriamientoPowerUp_timeout():
	fuerza_salto = fuerza_salto_original

func _on_EnfriamientoPowerUpVolar_timeout():
	animacion_personaje.play("default")
	acel_caida = acel_caida_original

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "entrar_portal":
		animacion_personaje.play("oscurecer")


func tomar_direccion():
	var direccion = 0
	if puede_moverse:
		direccion = Input.get_action_strength("mov_derecha") - Input.get_action_strength("mov_izquierda")
		if direccion == 0:
			animacion.play("default")
			$Particles.emitting = false
		else:
			if direccion < 0:
				animacion.flip_h = true
			else:
				animacion.flip_h = false
			animacion.play("correr")
			$Particles.emitting = true
	return direccion
	
func caer():
	if not is_on_floor():
		$Particles.emitting = false
		animacion.play("saltar")
		movimiento.y += acel_caida
		movimiento.y = clamp(movimiento.y, impulso, velocidad.y)

func saltar():
	if Input.is_action_just_pressed("salto") and is_on_floor() and puede_moverse:
		audio_salto.play()
		animacion.play("saltar")
		saltar_movimiento()

func saltar_movimiento():
	movimiento.y = 0
	movimiento.y -= fuerza_salto

func colision_techo():
	if is_on_ceiling():
		movimiento.y = fuerza_rebote
		
func impulsar():
	movimiento.y = impulso

func caida_al_vacio():
	if position.y > camara.limit_bottom:
		respawn()
		
func respawn():
	DatosPlayers.restar_vidas()
	animacion_personaje.play("oscurecer")
	if DatosPlayers.vidas > 0:  # No es recomendado acceder directamente a la var...  debemos usar setters y getters
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()

## Power-Up functions ##

func cambiar_fuerza_salto():
	enfriamiento_power_up.start()
	fuerza_salto = -impulso * 0.9

func volar():
	enfriamiento_power_up_volar.start()
	acel_caida = 60
	animacion_personaje.play("volar")
	saltar_movimiento()

## end power up

func play_entrar_portal(posicion_portal):
	puede_moverse = false
	if player_selected == "player1":
		animacion_personaje.play("entrar_portal")
	else:
		animacion_personaje.play("entrar_portal_2")
	$Tween.interpolate_property(
		self,
		"global_position",
		global_position,
		posicion_portal,
		0.8,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	$Tween.start()

func shoot_ctrl():
	if puede_disparar:
		var shoot = proyectil.instance()
		shoot.crear($PosicionDisparo.global_position, animacion.flip_h)
		owner.add_child(shoot)
		$AudioDisparo.play()
		puede_disparar = false
		enfriamiento_disparo.start()


func _on_EnfriamientoDisparo_timeout():
	puede_disparar = true
