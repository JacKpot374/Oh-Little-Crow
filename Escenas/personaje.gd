extends CharacterBody2D

# Variables configurables
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var MAX_JUMPS = 2 # Límite de saltos permitidos
@export var vida : int = 3
@export var texto_vida: Label

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0 # Rastrea cuántos saltos llevamos en el aire

# Referencia al nodo visual para poder voltearlo
@onready var sprite = $Sprite2D

func _ready():
	# Muestra la vida inicial al arrancar el nivel
	if texto_vida != null:
		texto_vida.text = "Vidas: " + str(vida)

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
			sprite.flip_h = false # Voltea hacia la izquierda
		elif direction > 0:
			sprite.flip_h = true # Lo mantiene hacia la derecha
	else:
		# Frenado suave
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 4. Procesar físicas
	move_and_slide()
	
# === SISTEMA DE VIDA DEL PERSONAJE ===

func recibir_dano(cantidad):
	vida -= cantidad
	print("Auch! Vida actual: ", vida)
	
	if texto_vida != null:
		texto_vida.text = "Vidas: " + str(vida)
	
	sprite.modulate = Color.RED
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color.WHITE, 0.3)
	# Esta condición ahora está correctamente dentro de la función (con doble tabulación)
	if vida <= 0:
		print("El personaje ha muerto")
		get_tree().change_scene_to_file("res://Escenas/Game over.tscn")
		queue_free()
		
