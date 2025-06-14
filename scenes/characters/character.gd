extends CharacterBody2D

@export var damage : int
@export var health : int
@export var speed : float

@onready var aniamtion_player: AnimationPlayer = $AnimationPlayer
@onready var character_sprite: Sprite2D = $CharacterSprite
@onready var damage_emitter: Area2D = $DamageEmitter


enum State {IDLE, WALK, ATTACK}
var state = State.IDLE

func _ready() -> void:
	damage_emitter.area_entered.connect(on_emit_damage.bind())

func _physics_process(_delta: float) -> void:
	handle_input()
	handle_movement()
	handle_animation()
	flip_sprites()
	move_and_slide()


func handle_movement() -> void:
	if can_move():
		if velocity.length()  == 0:
			state = State.IDLE
		else:
			state = State.WALK
	else:
		velocity = Vector2.ZERO

func handle_input() -> void:	
	var dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = dir * speed
	
	if can_attack() and Input.is_action_just_pressed("attack"):
		state = State.ATTACK
		

func handle_animation() -> void:
	if state == State.IDLE:
		aniamtion_player.play("idle")
	elif state == State.WALK:
		aniamtion_player.play("walk")
	elif state == State.ATTACK:
		aniamtion_player.play("punch")
		

func flip_sprites() -> void:
	if velocity.x >0:
		character_sprite.flip_h = false
		damage_emitter.scale.x = 1
	elif velocity.x < 0:
		character_sprite.flip_h = true
		damage_emitter.scale.x = -1
		
func can_move() -> bool:
	return state == State.IDLE or state == State.WALK
func can_attack()->bool:
	return state == State.IDLE or state == State.WALK

func on_action_complete() -> void:
	state = State.IDLE

func on_emit_damage(damage_receiver: DamageReceiver) -> void:
	var direction := Vector2.LEFT if damage_receiver.global_position.x < global_position.x else Vector2.RIGHT
	damage_receiver.damage_received.emit(damage, direction)
