extends CharacterBody2D

# Variables configurables
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var MAX_JUMPS = 2 # Límite de saltos permitidos

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0 # Rastrea cuántos saltos llevamos en el aire

# Referencia al nodo visual para poder voltearlo
@onready var sprite = $Crow

func _physics_process(delta):
	# 1. Aplicar Gravedad y reiniciar el contador de saltos al tocar el suelo
	if is_on_floor():
		jump_count = 0
	else:
		velocity.y += gravity * delta

	# 2. Lógica de Salto y Doble Salto
	if Input.is_action_just_pressed("ui_accept"):
		# Permite saltar si estamos en el suelo o si no hemos superado el límite
		if is_on_floor() or jump_count < MAX_JUMPS:
			velocity.y = JUMP_VELOCITY
			jump_count += 1

	# 3. Lógica de Movimiento Horizontal
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
		
		# Lógica para reflejar el personaje (Mirar izquierda o derecha)
		if direction < 0:
			sprite.flip_h = false  # Voltea hacia la izquierda
		elif direction > 0:
			sprite.flip_h = true # Lo mantiene hacia la derecha
	else:
		# Frenado suave
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 4. Procesar físicas
	move_and_slide()
