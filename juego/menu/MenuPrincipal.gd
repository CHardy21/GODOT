extends Control

export var nivel_inicio = ""

onready var nubes_lejanas = $ParallaxBackground/ParallaxNubesLejanas


func _ready():
	DatosPlayers.reset()


func _process(_delta):
	nubes_lejanas.motion_offset.x -= 1

func _on_BotonIniciar_pressed():
	MusicalGlobal.replay()
# warning-ignore:return_value_discarded
	get_tree().change_scene(nivel_inicio)
