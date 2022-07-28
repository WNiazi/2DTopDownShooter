extends CanvasLayer

#onready var lives = PlayerScore.lives
#onready var lives_bar = $MarginContainer/Row/TopRow/LivesBar
onready var health_bar =$MarginContainer/Row/BottomRow/HealthBar
onready var current_ammo =$MarginContainer/Row/BottomRow/AmmoInfo/CurrentAmmo
onready var max_ammo =$MarginContainer/Row/BottomRow/AmmoInfo/MaxAmmo
onready var health_tween =$MarginContainer/Row/BottomRow/HealthBar/HealthTween

var player: Player
#pass player variable using dependency injection to give player to GUI and then GUI set health value 
func set_player(player: Player): 
	self.player = player 
	#this will get a new player when player dies 
	set_new_health_value(player.health_stat.health)
	player.connect("player_health_changed", self, "set_new_health_value") #this will update health bar
	set_weapon(player.weapon_manager.get_current_weapon())
	player.weapon_manager.connect ("weapon_changed", self, "set_weapon")

func set_weapon ( weapon:Weapon):
	set_current_ammo(weapon.current_ammo)
	set_max_ammo (weapon.max_ammo)
	if not weapon.is_connected("weapon_ammo_changed", self, "set_current_ammo"):
		weapon.connect ("weapon_ammo_changed", self, "set_current_ammo")
	
func set_new_health_value(new_health: int): 
	var original_color = Color("#1b310c")
	var highlight_color = Color ("#c7dbba")
	#var bar_styles = health_bar.get("custom_styles/fg")
	
	health_tween.interpolate_property(health_bar, "value", health_bar.value, new_health, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN)
	health_tween.interpolate_property(health_bar.get("custom_styles/fg"), "bg_color", original_color, highlight_color, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	health_tween.interpolate_property(health_bar.get("custom_styles/fg"), "bg_color", highlight_color, original_color, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.2)
	health_tween.start() 
	
	
func set_current_ammo(new_ammo: int): 
	current_ammo.text =str(new_ammo)
		
func set_max_ammo(new_max_ammo: int): 
	max_ammo.text = str(new_max_ammo) 
