global.p_xp += 20 / global.p_level * 0.63
if (instance_exists(obj_hud)){
	if (global.energy < obj_hud.p_energy_max) global.energy++
}
instance_destroy(other.id)