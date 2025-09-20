extends Area2D

@export var speed = 400
var screen_size
signal hit


func start(pos):
	position = pos
	show()
	$CollisionShape2D.set_deferred("disabled",false)

func _ready() -> void:
	hide()
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	velocity.y = Input.get_axis("move_up","move_down")
	velocity.x = Input.get_axis("move_left","move_right")
	
	velocity = velocity.normalized()
	
	if velocity.x != 0:
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta * speed
	position = position.clamp(Vector2.ZERO,screen_size)
	


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled",true)
