// --- 0. Setup de Segurança ---
draw_set_font(fnt_hud);
draw_set_alpha(1);
draw_set_color(c_white);

// --- 1. CONFIGURAÇÕES DE POSSES
// ==========================================================
var _tem_hab1 = global.hab1; 
var _tem_hab2 = global.hab2; 
// ==========================================================

// --- 2. Lógica de Itens Dinâmicos ---
var _itens = [];
array_push(_itens, {val: global.vel,  lab: "SPEED",  key: "1", idx: 0, skill: false});
array_push(_itens, {val: global.energy, lab: "ENERGY", key: "2", idx: 1, skill: false});
array_push(_itens, {val: p_regen,  lab: "REGEN",  key: "3", idx: 2, skill: false});
if (_tem_hab1) array_push(_itens, {val: "Z", lab: "HAB 1", key: "4", idx: 3, skill: true});
if (_tem_hab2) array_push(_itens, {val: "X", lab: "HAB 2", key: "5", idx: 4, skill: true});

var _num_itens = array_length(_itens);

// --- 3. Layout Redimensionado (Largura Corrigida) ---
// Aumentei a base para 380 e o multiplicador para 75 para garantir que a HAB 2 não pule fora
var _w = 340 + (_num_itens * 75); 
var _h = 95; 
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

var _xb = floor((_gw / 2) - (_w / 2));
var _yb = floor(_gh - _h - 15);
var _cy = floor(_yb + (_h / 2) + 2); 

// --- 4. Background Neon Restaurado ---
draw_set_alpha(0.85);
draw_set_color(make_color_rgb(5, 2, 15)); 
draw_roundrect_ext(_xb, _yb, _xb + _w, _yb + _h, 12, 12, false);

// Borda superior de brilho
draw_set_alpha(0.2); draw_set_color(c_white);
draw_line(_xb + 15, _yb + 2, _xb + _w - 15, _yb + 2);

// Contorno Neon
draw_set_alpha(0.3); draw_set_color(make_color_rgb(120, 70, 255));
draw_roundrect_ext(_xb, _yb, _xb + _w, _yb + _h, 12, 12, true);

// --- 5. Barra de XP (RESTAURADA) ---
var _xp_val = clamp(global.p_xp, 0, 100);
if (_xp_val > 0) {
    var _px = _xp_val / 100;
    var _x1 = _xb + 100;
    var _x2 = _xb + _w - 100;
    var _y_xp = _yb + 8;
    var _xf = _x1 + (_x2 - _x1) * _px;
    
    draw_set_alpha(0.2); draw_set_color(c_aqua);
    draw_line_width(_x1, _y_xp, _xf, _y_xp, 3); // Brilho
    draw_set_alpha(1); draw_set_color(c_white);
    draw_line_width(_x1, _y_xp, _xf, _y_xp, 1); // Linha sólida
}

// --- 6. Área do Nível ---
draw_set_halign(fa_center); draw_set_valign(fa_middle);
var _lvl_x = _xb + 60;
var _lvl_y = _cy - 5; 
var _pulse = sin(current_time * 0.003) * 2;

draw_set_alpha(0.15); draw_set_color(make_color_rgb(150, 100, 255));
draw_circle(_lvl_x, _lvl_y, 26 + _pulse, false);
draw_set_alpha(0.5); draw_set_color(make_color_rgb(180, 140, 255));
draw_circle(_lvl_x, _lvl_y, 26, true);

draw_set_alpha(1); draw_set_color(c_black);
draw_text_transformed(_lvl_x + 1, _lvl_y + 1, string(global.p_level), 0.7, 0.7, 0);
draw_set_color(c_white);
draw_text_transformed(_lvl_x, _lvl_y, string(global.p_level), 0.7, 0.7, 0);

if (p_points > 0) {
    draw_set_color(c_yellow);
    draw_text_transformed(_lvl_x, _yb + _h - 10, "PTS: " + string(p_points), 0.35, 0.35, 0);
}

// --- 7. Função de Desenho de Itens ---
var _draw_item = function(_ix, _iy, _val, _label, _key, _idx, _pts, _is_skill) {
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    var _y_main = _iy - 12; var _y_label = _iy + 12; var _y_upg = _iy + 32;
    
    // Atalhos 1-5
    var _key_pressed = keyboard_check_pressed(ord(_key));
    var _hov = (_pts > 0) && (point_distance(_mx, _my, _ix, _y_upg) < 10);

    if (_pts > 0 && (_key_pressed || (_hov && mouse_check_button_pressed(mb_left)))) {
        switch(_idx) {
            case 0: if global.vel < p_speed_max {p_points -= 1; global.vel += 0.5; } break;
            case 1: if p_energy_max < p_energy_max_level {p_points -= 1; p_energy_max += 5; } break;
            case 2: if p_regen < p_regen_max {p_points -= 1; p_regen += 0.2; } break;
            case 3: if (global.hab1_atual < global.hab1_max) { p_points -= 1; global.hab1_atual += 1; } break; 
            case 4: if (global.hab2_atual < global.hab2_max) { p_points -= 1; global.hab2_atual += 1; } break;
        }
    }

    if (_is_skill) {
        draw_set_color(make_color_rgb(0, 180, 255));
        draw_circle(_ix, _y_main, 16, true);
        draw_set_color(c_white);
        draw_text_transformed(_ix, _y_main, _val, 0.6, 0.6, 0);
        
        // Pips (Bolinhas de Nível)
        var _lvl_max = (_idx == 3) ? global.hab1_max : global.hab2_max;
        var _lvl_at  = (_idx == 3) ? global.hab1_atual : global.hab2_atual;
        for (var i = 0; i < _lvl_max; i++) {
            var _px_pip = _ix - ((_lvl_max-1)*7)/2 + (i*7);
            if (i < _lvl_at) {
                draw_set_alpha(0.4); draw_set_color(c_aqua); draw_circle(_px_pip, _y_main - 22, 3, false);
                draw_set_alpha(1); draw_set_color(c_white); draw_circle(_px_pip, _y_main - 22, 1.5, false);
            } else {
                draw_set_alpha(0.3); draw_set_color(c_dkgray); draw_circle(_px_pip, _y_main - 22, 1.5, true);
            }
        }
    } else {
        draw_set_color(c_black);
        var _txt = (_label == "ENERGY") ? string(floor(global.energy)) + "/" + string(floor(global.energy_max)) : string(_val);
        draw_text_transformed(_ix+1, _y_main+1, _txt, 0.55, 0.55, 0);
        draw_set_color(c_white);
        draw_text_transformed(_ix, _y_main, _txt, 0.55, 0.55, 0);
    }

    draw_set_alpha(0.7); draw_set_color(c_silver);
    draw_text_transformed(_ix, _y_label, _label, 0.35, 0.35, 0);

    if (_pts > 0) {
        var _u_pulse = abs(sin(current_time * 0.006)) * 2;
        draw_set_alpha(0.2); draw_set_color(_hov ? c_white : make_color_rgb(140, 90, 255));
        draw_circle(_ix, _y_upg, 8 + _u_pulse, false);
        draw_set_alpha(1); draw_set_color(_hov ? c_white : make_color_rgb(140, 90, 255));
        draw_circle(_ix, _y_upg, 8, true);
        draw_text_transformed(_ix, _y_upg, _key, 0.4, 0.4, 0);
    }
};

// --- 8. Renderização Final com Espaçamento Seguro ---
var _startX = _xb + 175; // Ponto de partida dos itens
var _espaco_disponivel = _w - 230; 
var _sp = (_num_itens > 1) ? _espaco_disponivel / (_num_itens - 1) : 0;

for (var i = 0; i < _num_itens; i++) {
    var _item = _itens[i];
    var _posX = (_num_itens == 1) ? _xb + (_w/2) + 40 : _startX + (i * _sp);
    _draw_item(_posX, _cy, _item.val, _item.lab, _item.key, _item.idx, p_points, _item.skill);
}

// Reset final
draw_set_alpha(1)
draw_set_halign(-1)
draw_set_valign(-1)
draw_set_font(-1)

