extends Control

export var menu_principal = ""

var nivel_actual = ""


func _ready():
	nivel_actual = DatosPlayers.nivel_actual
	DatosPlayers.reset()

func _on_BotonMenuPrincipal_pressed():
	get_tree().change_scene(menu_principal)

func _on_BotonMenuReintentar_pressed():
	get_tree().change_scene(nivel_actual)
