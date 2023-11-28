extends ItemContainer

func hit():
	if not opened:
		$LidSprite.hide()
		opened = true
		var pos = $SpawnPosition/Marker2D.global_position
		open.emit(pos, current_direction)
