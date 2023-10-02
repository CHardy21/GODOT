extends Node

signal actualizar_datos()
signal game_over()

var vidas = 3
var llaves = 0
var monedas_oro = 0
var monedas_plata = 0
var monedas_bronce = 0
var nivel_actual = ""
var nivel_name = ""
var puntaje = 0

func reset():
	vidas = 3
	llaves = 0
	monedas_oro = 0
	monedas_plata = 0
	monedas_bronce = 0


func generar_puntaje():
	var valor_oro = monedas_oro * 15
	var valor_plata = monedas_plata * 10
	var valor_bronce = monedas_bronce * 5 
	puntaje = valor_oro + valor_plata + valor_bronce
	return puntaje


func restar_vidas():
	vidas -= 1
	#print("vidas restantes: ", vidas)
	if vidas == 0:
		emit_signal("game_over")
	emit_signal("actualizar_datos")


func restar_llaves():
	llaves -= 1
	emit_signal("actualizar_datos")


func contabilizar_llaves(cantidad_llaves_en_nivel):
	llaves = cantidad_llaves_en_nivel
	emit_signal("actualizar_datos")


func sumar_monedas(moneda):
	match moneda:
		"oro":
			monedas_oro += 1
		"plata":
			monedas_plata += 1
		"bronce":
			monedas_bronce += 1
		_:
			print("ERROR. Moneda no existe")
	emit_signal("actualizar_datos")

