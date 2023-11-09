extends Node

func sfx_enter():
	$ui_enter.play()

func sfx_back():
	$ui_back.play()
	
func music_menu_start():
	$music_menu.play()
	
func music_menu_stop():
	$music_menu.stop()

func music_level_start():
	$music_level.play()

func music_level_stop():
	$music_level.stop()

func stinger_gameover_start():
	$stinger_death_oneshot.play()
	$stinger_deathloop.play()
	
func stinger_gameover_stop():
	$stinger_death_oneshot.stop()
	$stinger_deathloop.stop()
