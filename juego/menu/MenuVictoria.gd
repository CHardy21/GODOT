extends Control


func _ready():
	$Puntaje.text = "Puntaje:   %s" % DatosPlayers.generar_puntaje()
	# $Puntaje.text = "Puntaje: {p}".format({"p" :  DatosPlayers.generar_puntaje() })


func _on_BotonMenuPrincipal_pressed():
	get_tree().change_scene("res://juego/menu/MenuPrincipal.tscn")
