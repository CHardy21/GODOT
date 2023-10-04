extends Control

export var nivel_inicio = ""

onready var nubes_lejanas = $ParallaxBackground/ParallaxNubesLejanas
onready var animacion_personaje = $AnimationPlayer

func _ready():
	DatosPlayers.reset()


func _process(_delta):
	nubes_lejanas.motion_offset.x -= 1

func _on_BotonIniciar_pressed():
	MusicalGlobal.replay()
	DatosPlayers.player_selected = $AnimatedSprite.animation
	print( $AnimatedSprite.animation)
# warning-ignore:return_value_discarded
	get_tree().change_scene(nivel_inicio)

#func _input(event):
#	if event.is_action_pressed("mov_derecha") or event.is_action_pressed("mov_izquierda"):
#		change_player()
		
func change_player():
#	animacion_personaje.stop()
	if $AnimatedSprite.animation == "player1":
		animacion_personaje.stop()
		$AnimatedSprite.animation = "player2"
		animacion_personaje.play("animacion_player2")
	else:
		animacion_personaje.stop()
		$AnimatedSprite.animation = "player1"
		animacion_personaje.play("animacion_menu")
		



func _on_BotonCambiarPlayer_pressed():
	change_player()
