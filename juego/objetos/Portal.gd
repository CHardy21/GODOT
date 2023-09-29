extends Area2D

export var proximo_nivel = ""

var esta_activado = false


#func _ready():
#	get_parent().connect("abrir_portal",self,"play_animacion_abrir_portal")

func _on_body_entered(body):
	if esta_activado:
		body.play_entrar_portal(global_position)
		yield(get_tree().create_timer(1.2),"timeout")
		cambiar_nivel()


func cambiar_nivel():
# warning-ignore:return_value_discarded
	get_tree().change_scene(proximo_nivel)


func play_animacion_abrir_portal():
	esta_activado = true
	$AnimationPlayer.play("activado")
	$AnimatedSprite.play("default")

