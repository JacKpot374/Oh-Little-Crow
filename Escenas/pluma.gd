extends Area2D

func _on_body_entered(body):
	# Verifica si el cuerpo que tocó la pluma es el cuervo
	if body.name == "Personaje": 
		queue_free() # Destruye el nodo de la pluma inmediatamente
