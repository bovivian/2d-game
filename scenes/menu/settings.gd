extends Control


var music_volume := 1.0
var graphics_quality := 0  # 0=Low, 1=Medium, 2=High


func save_settings():
	var config = ConfigFile.new()
	config.set_value("audio", "music_volume", music_volume)
	config.set_value("graphics", "quality", graphics_quality)
	config.save("user://settings.cfg")
	

func load_settings():
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		music_volume = config.get_value("audio", "music_volume", 1.0)
		graphics_quality = config.get_value("graphics", "quality", 1)
		

func _ready():
	music_volume = SoundManager.get_bgm_volume_db()
	$VBoxContainer/HBoxContainer/VolumeSlider.value = music_volume

func _on_volume_slider_drag_ended(value_changed: bool):
	if (value_changed):
		music_volume = $VBoxContainer/HBoxContainer/VolumeSlider.value
		SoundManager.set_bgs_volume_db(music_volume)
		SoundManager.set_bgm_volume_db(music_volume)
		SoundManager.set_sfx_volume_db(music_volume)
		SoundManager.set_mfx_volume_db(music_volume)
		SoundManager.get_playing_sounds()
		set_volume_for_all_playing_sounds(music_volume)


func set_volume_for_all_playing_sounds(volume_db: float) -> void:
	var playing_sounds = SoundManager.get_playing_sounds()
	for sound in playing_sounds:
		var sound_index = SoundManager.find_sound(sound)
		if sound_index >= 0:
			SoundManager.Audiostreams[sound_index].set_volume_db(volume_db)
