extends Area2D

# Cantidad de daño que hace este objeto
@export var dano: int = 1 

func _on_body_entered(body):
	# Verifica si el cuerpo que chocó tiene la función "recibir_dano" en su script
	if body.has_method("recibir_dano"):
		# Si la tiene, ejecuta esa función y le pasa la cantidad de daño
		body.recibir_dano(dano)
