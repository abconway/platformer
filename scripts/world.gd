extends Node2D


@onready var player_spawn = $PlayerSpawn
@onready var coin_spawn = $CoinSpawn
@onready var box_spawn = $BoxSpawn
@onready var box_timer = $BoxTimer
@onready var boxes = $Boxes
@onready var coin_timer = $CoinTimer


@onready var ui = $UI
@onready var pause_menu = $UI/PauseMenu
@onready var main_menu = $UI/MainMenu
@onready var start_menu = $UI/StartMenu
@onready var score_label = $UI/PauseMenu/BoxContainer/HBoxContainer/Panel/Score

const box = preload("res://scenes/box.tscn")
const player = preload("res://scenes/player.tscn")
const coin = preload("res://scenes/coin.tscn")

var score := 0
var current_player: Player


func _ready():
	ui.process_mode = Node.PROCESS_MODE_ALWAYS
	pause_menu.hide()
	main_menu.hide()
	start_menu.show()


func _physics_process(delta):
	for b in boxes.get_children():
		b.position.x -= 100 * delta


func set_score():
	score_label.text = "Score: " + str(score)


func reset_game():
	if not current_player:
		var p := player.instantiate()
		p.global_position = player_spawn.global_position
		add_child(p)
		current_player = p
	score = 0
	set_score()
	for b in boxes.get_children():
		b.queue_free()
	box_timer.stop()
	box_timer.start()
	coin_timer.stop()
	coin_timer.start()


func _on_pause_pressed():
	get_tree().paused = true
	pause_menu.hide()
	main_menu.show()


func _on_restart_pressed():
	reset_game()


func _on_close_pressed():
	get_tree().paused = false
	pause_menu.show()
	main_menu.hide()


func _on_score_counter_area_entered(area):
	if is_instance_valid(current_player):
		score += 1
		set_score()


func _on_start_pressed():
	start_menu.hide()
	pause_menu.show()
	reset_game()


func _on_box_timer_timeout():
	var new_box := box.instantiate()
	new_box.global_position = box_spawn.global_position
	boxes.add_child(new_box)
	box_timer.wait_time = randf_range(1, 3)


func _on_coin_timer_timeout():
	var new_coin := coin.instantiate()
	new_coin.global_position = coin_spawn.global_position
	new_coin.collected.connect(_on_coin_collected)
	boxes.add_child(new_coin)
	coin_timer.wait_time = randf_range(1, 3)


func _on_coin_collected():
	score += 1
	set_score()
