extends Node2D


@onready var camera: Camera2D = $Camera
@onready var player: CharacterBody2D = $ActionContainer/Player

func _process(_delta: float) -> void:
	if player.position.x > camera.position.x:
		camera.position.x = player.position.x
