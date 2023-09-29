extends Area2D

export var velocidad = 600.0

var mi_pos = Vector2.ZERO

onready var animacion = $AnimatedSprite


func _ready():
	global_position = mi_pos
	animacion.play("shoot")


func _process(delta):
	global_position.x += velocidad * delta 


func _on_VisibilityNotifier2D_screen_exited():
	destruir_proyectil()


func _on_Proyectil_area_entered(area):
	print("impacte en algo (area) -> ", area.get_parent().name)
	if area.owner.is_in_group("Enemy") or area.is_in_group("Enemy") :
		print("Impacte en enemigo...", area.owner.name)
		# Aqui se podria poner algun efecto de explosion
		# y luego de finalizado el efecto llamar recien llamar a queue_free()
		destruir_proyectil()


#func _on_Proyectil_body_entered(body):
#	if body.owner.is_in_group("Enemy"):
#		print("Impacte en enemigo...", body.name)
#		destruir_proyectil()
#	print("Impacte con algo (body)", body.name)


func destruir_proyectil():
	queue_free()

func crear(pos, dir):
	mi_pos = pos
	if dir:
		velocidad *= -1  # determina hacia donde va el proyectil (der o izq)

