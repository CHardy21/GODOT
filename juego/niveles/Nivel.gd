extends Node

#signal abrir_portal()

export var menu_game_over = "res://juego/menu/MenuGameOver.tscn"
export var nivel_actual = ""
export var nivel_name = ""

var numero_llaves = 0
var contenedor_llaves

onready var nubes_lejanas = $ParallaxBackground/ParallaxNubesLejanas


func _ready():
# warning-ignore:return_value_discarded
	DatosPlayers.connect("game_over", self, "game_over")
	contenedor_llaves = get_node_or_null("Zanahorias")
	DatosPlayers.nivel_name = nivel_name
	if contenedor_llaves != null:
		numero_llaves_nivel()
		
func _process(_delta):
	nubes_lejanas.motion_offset.x -= 5
	
func numero_llaves_nivel():
	numero_llaves = contenedor_llaves.get_child_count()
	DatosPlayers.contabilizar_llaves(numero_llaves)
	
	## 3. Conecto mi señal personalida con este script
	for llave in contenedor_llaves.get_children():
		llave.connect("consumir_llave", self,"llaves_restantes")
		
	#print(numero_llaves)
	
func llaves_restantes():
	numero_llaves -= 1
	# print(numero_llaves)
	
	if numero_llaves == 0: ## si no hay mas llaves debe abrir portal
		# print("Abrir Portal")
		##emit_signal("abrir_portal")
		## para abrir el portal sin usar señales el codigo seria:
		var portal = get_node_or_null("Portal")
		portal.play_animacion_abrir_portal()

func game_over():
	DatosPlayers.nivel_actual = nivel_actual
# warning-ignore:return_value_discarded
	get_tree().change_scene(menu_game_over)

