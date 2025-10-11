extends Node

const MINUTES_PER_DAY: int = 24*60
const MINUTES_PER_HOUR: int = 60
const GAME_MINUTE_DURATION: float = TAU / MINUTES_PER_DAY

var game_speed: float = 5.0
var initial_day: int = 1
var initial_hour: int = 10
var initial_minute: int = 0

var time: float = 0.0
var current_minute: int = -1
var current_day: int = 0

var timer: float = 0.0

signal game_time(time: float)
signal time_tick(day: int, hour: int, minute: int)
signal time_tick_day(day: int)
signal real_second_tick()

var signal_over : bool = true
signal two_o_clock()
signal four_o_clock()
signal six_o_clock()
signal eighteen_o_clock()
signal twenty_o_clock()

func _ready() -> void:
	set_initial_time()
	
func _process(delta: float) -> void:
	time += delta * game_speed * GAME_MINUTE_DURATION
	game_time.emit(time)
	
	timer += delta
	if timer >= 1.0:
		timer = 0
		real_second_tick.emit()
	
	recalculate_time()

func set_initial_time() -> void:
	var initial_total_minutes = initial_day * MINUTES_PER_DAY + (initial_hour * MINUTES_PER_HOUR) + initial_minute
	
	time = initial_total_minutes * GAME_MINUTE_DURATION

func recalculate_time() -> void:
	var total_minutes: int = int(time / GAME_MINUTE_DURATION)
	@warning_ignore("integer_division")
	var day: int = int(total_minutes / MINUTES_PER_DAY)
	var current_day_minutes: int = total_minutes % MINUTES_PER_DAY
	@warning_ignore("integer_division")
	var hour: int = int(current_day_minutes / MINUTES_PER_HOUR)
	var minute: int = int(current_day_minutes % MINUTES_PER_HOUR)
	
	if hour == 2:
		if signal_over:
			two_o_clock.emit()
			signal_over = false
	elif hour == 4:
		if signal_over:
			four_o_clock.emit()
			signal_over = false
	elif hour == 6:
		if signal_over:
			six_o_clock.emit()
			signal_over = false
	elif hour == 18:
		if signal_over:
			eighteen_o_clock.emit()
			signal_over = false
	elif hour == 20:
		if signal_over:
			twenty_o_clock.emit()
			signal_over = false
	else:
		signal_over = true
		
	
	if current_minute != minute:
		current_minute = minute
		time_tick.emit(day, hour, minute)
	
	if current_day != day:
		current_day = day
		time_tick_day.emit(day)
