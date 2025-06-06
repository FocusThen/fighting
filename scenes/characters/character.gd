extends CharacterBody2D


@export var health : int
@export var damage : int
@export var speed : float


func _physics_process(delta: float) -> void:
	var dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = dir * speed
	move_and_slide()
