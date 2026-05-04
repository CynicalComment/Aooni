extends Node

#WHAT GETS PLAYED????
@onready var music_player = $AmbientAudio
@onready var sting_player = $StingAudio # for horror stings/stabs
@onready var heartbeat_player = $HeartbeatAudio #currently not in use

#THE ACTUAL DATA
@export var music_chase : AudioStream
@export var music_ambient : AudioStream
@export var music_heartbeat : AudioStream


func play_heartbeat(): #fuck em not in use
	if music_player.stream == music_heartbeat and music_player.playing:
		return
	music_player.stream = heartbeat_player
	music_player.play()
	
func play_ambient():
	if music_player.stream == music_ambient and music_player.playing:
		return
	music_player.stream = music_ambient	
	print("MUSIC NOW", music_ambient)
	music_player.play()

func play_chase():
	if music_player.stream == music_chase and music_player.playing:
		return
	music_player.stream = music_chase
	music_player.play()

func play_sting(sting: AudioStream):
	sting_player.stream = sting
	sting_player.play()

func stop_music():
	music_player.stop()
