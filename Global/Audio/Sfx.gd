extends Node

const SFX_BUS = 1
const MUSIC_BUS = 2

# For background audio
@onready var music : AudioStreamPlayer = $MusicPlayer;
var music_tween : Tween

# For button noises
func click():
	$Click.play()
	
func _ready():
	connect(%SoundSlider.value_changed, func(value):
		AudioServer.set_bus_volume_db(SFX_BUS, value)
	)
	connect(%MusicSlider.value_changed, func(value):
		AudioServer.set_bus_volume_db(MUSIC_BUS, value)
	)

# Trigger audio start on first mouse input for web builds.
func _input(event):
	if event is InputEventMouse:
		if music.stream != null and not music.playing:
			music.play()

func play_music(stream : AudioStream, volume_db: float = 0.0):
	if music_tween != null:
		music_tween.stop()
		music_tween = null
	music.volume_db = volume_db
	music.stream = stream
	music.play()

func fade_music_out(duration: float, target_db: float = -30.0) -> Signal:
	music_tween = create_tween()
	music_tween.tween_property(music, "volume_db", target_db, duration)
	if target_db <= -30.0:
		music_tween.tween_callback(music.stop)
	return music_tween.finished
