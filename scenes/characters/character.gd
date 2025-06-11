extends CharacterBody2D

@export var damage : int
@export var health : int
@export var speed : float

@onready var aniamtion_player = $AnimationPlayer
@onready var character_sprite = $CharacterSprite


enum State {IDLE, WALK}
var state = State.IDLE

func _physics_process(_delta: float) -> void:
	handle_input()
	handle_movement()
	handle_animation()
	flip_sprites()
	move_and_slide()


func handle_movement():
	if velocity.length()  == 0:
		state = State.IDLE
	else:
		state = State.WALK


func handle_input():	
	var dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = dir * speed
	

func handle_animation():
	if state == State.IDLE:
		aniamtion_player.play("idle")
	elif state == State.WALK:
		aniamtion_player.play("walk")
		
		

func flip_sprites():
	if velocity.x >0:
		character_sprite.flip_h = false
	elif velocity.x < 0:
		character_sprite.flip_h = true
