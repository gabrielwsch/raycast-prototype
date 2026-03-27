draw_set_alpha(0.7);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_font(-1)
var _gui_width = display_get_gui_width();
var _x = _gui_width / 2;

// --- Lógica do Texto da Fase ---
var _phase_word = "Phase";
if (global.fase_atual % 10 == 0) {
    _phase_word = "PHASE"; 
}
var _txt_header = string(map_name) + " - " + _phase_word + " " + string(global.fase_atual);

// --- NOVA LÓGICA DO CRONÔMETRO (Formatado) ---
var _total_segundos = floor(tempo_room);
var _minutos = _total_segundos div 60; // Pega os minutos
var _segundos = _total_segundos % 60;  // Pega o que sobra (segundos)

// Adiciona o "0" na frente se for menor que 10 para ficar 00:00
var _str_min = (_minutos < 10) ? "0" + string(_minutos) : string(_minutos);
var _str_seg = (_segundos < 10) ? "0" + string(_segundos) : string(_segundos);

var _txt_timer = _str_min + ":" + _str_seg;

// --- DESENHO ---

// Sombra (Preta)
draw_set_color(c_black);
draw_text(_x + 2, 22, _txt_header);
draw_text(_x + 2, 52, _txt_timer);

// Texto Principal (Branco)
draw_set_color(c_white);
draw_text(_x, 20, _txt_header);
draw_text(_x, 50, _txt_timer);

draw_set_alpha(1.0);