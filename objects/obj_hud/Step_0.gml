if (global.p_xp >= 100){
	global.p_xp = 0
	global.p_level++
	p_points++
}
if global.energy < p_energy_max and alarme = 1{
	alarm[0] = 60 / p_regen
	alarme = 0
}

p_speed = global.vel
global.vel = p_speed
global.energy_max = p_energy_max
