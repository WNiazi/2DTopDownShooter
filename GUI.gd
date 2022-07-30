extends CanvasLayer

onready var health_bar = $MarginContainer/Row/BottomRow/HealthBar
onready var health_tween = $MarginContainer/Row/BottomRow/HealthBar/HealthTween
onready var current_ammo = $MarginContainer/Row/BottomRow/AmmoInfo/CurrentAmmo
onready var max_ammo = $MarginContainer/Row/BottomRow/AmmoInfo/MaxAmmo
onready var score_ui =$MarginContainer/Row/TopRow/ScoreUI

var player: Player


func set_player(player: Player):
	self.player = player

	set_new_health_value(player.health_stat.health)
	player.connect("player_health_changed", self, "set_new_health_value")

	set_weapon(player.weapon_manager.get_current_weapon())
	player.weapon_manager.connect("weapon_changed", self, "set_weapon")
	


func set_weapon(weapon: Weapon):
	set_current_ammo(weapon.current_ammo)
	set_max_ammo(weapon.max_ammo)
	if not weapon.is_connected("weapon_ammo_changed", self, "set_current_ammo"):
		weapon.connect("weapon_ammo_changed", self, "set_current_ammo")


func set_new_health_value(new_health: int):
	var original_color = Color("#1b310c")
	var highlight_color = Color("#5a49ee")

	health_tween.interpolate_property(health_bar, "value", health_bar.value, new_health, 0.4,Tween.TRANS_LINEAR, Tween.EASE_IN)
	health_tween.interpolate_property(health_bar.get("custom_styles/fg"), "bg_color", original_color, highlight_color, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	health_tween.interpolate_property(health_bar.get("custom_styles/fg"), "bg_color", highlight_color, original_color, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.2)
	health_tween.start()


func set_current_ammo(new_ammo: int):
	current_ammo.text = str(new_ammo)


func set_max_ammo(new_max_ammo: int):
	max_ammo.text = str(new_max_ammo)
	

