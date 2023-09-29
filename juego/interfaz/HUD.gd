extends Control

onready var etiqueta_vidas = $ContenedorVidas/Cantidad
onready var etiqueta_monedas_oro = $ContenedorMonedasOro/Cantidad
onready var etiqueta_monedad_plata = $ContenedorMonedasPlata/Cantidad
onready var etiqueta_monedas_bronce = $ContenedorMonedasBronce/Cantidad
onready var etiqueta_llaves = $ContenedorLlaves/Cantidad


func _ready():
# warning-ignore:return_value_discarded
	DatosPlayers.connect("actualizar_datos", self, "actualizar_hud")
	actualizar_hud()


func actualizar_hud():
	etiqueta_vidas.text = "%s" % DatosPlayers.vidas
	etiqueta_monedas_oro.text = "%s" % DatosPlayers.monedas_oro
	etiqueta_monedad_plata.text = "%s" % DatosPlayers.monedas_plata
	etiqueta_monedas_bronce.text = "%s" % DatosPlayers.monedas_bronce
	etiqueta_llaves.text = "%s" % DatosPlayers.llaves
