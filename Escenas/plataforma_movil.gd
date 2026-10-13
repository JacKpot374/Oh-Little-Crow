extends AnimatableBody2D

# @export hace que estas variables aparezcan en el Inspector
@export var distancia_x: float = 300.0 # Cuántos píxeles se moverá
@export var distancia_y: float = -200.0
@export var tiempo_de_viaje: float = 2.0 # Cuántos segundos tarda

var posicion_inicial: Vector2

#func _ready():
	## Guarda la coordenada exacta donde pongas la plataforma en tu nivel
	#posicion_inicial = position 
	#var tween = create_tween().set_loops()
	#tween.set_trans(Tween.TRANS_SINE) # Movimiento suave
	## 1. Viaja hacia la derecha (Posición inicial + distancia)
	#tween.tween_property(self, "position:x", posicion_inicial.x + distancia_x, tiempo_de_viaje)
	#tween.tween_interval(1.0) # Pausa de 1 segundo
	## 2. Regresa al punto de origen
	#tween.tween_property(self, "position:x", posicion_inicial.x, tiempo_de_viaje)
	#tween.tween_interval(1.0) # Pausa de 1 segundo

func _ready():
	posicion_inicial = position 
	
	var tween = create_tween().set_loops()
	tween.set_trans(Tween.TRANS_SINE) 
	
	# 1. Viaja en el eje Y (Posición inicial + distancia_y)
	tween.tween_property(self, "position:y", posicion_inicial.y + distancia_y, tiempo_de_viaje)
	tween.tween_interval(1.0) 
	
	# 2. Regresa a la posición Y de origen
	tween.tween_property(self, "position:y", posicion_inicial.y, tiempo_de_viaje)
	tween.tween_interval(1.0)
