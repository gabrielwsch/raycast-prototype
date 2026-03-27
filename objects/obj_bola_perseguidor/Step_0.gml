var _chao = obj_chao;
var _player = obj_player2; // Nome do seu objeto player

// --- 1. LÓGICA DE INTELIGÊNCIA ---
if (instance_exists(_player)) {
    var _dist = distance_to_object(_player);
    
    if (_dist < raio_visao) {
        persegue_player = true;
        var _dir_alvo = point_direction(x, y, _player.x, _player.y);
        
        // Curva suave para não ser impossível de desviar
        direction += angle_difference(_dir_alvo, direction) * velocidade_curva;
		speed = 5
    } else {
        persegue_player = false;
		speed = 3.5;
    }
}

// --- 2. CÁLCULO DE MOVIMENTO ---
var _hspd = lengthdir_x(speed, direction);
var _vspd = lengthdir_y(speed, direction);

// --- 3. COLISÃO COM O CHÃO (Prevenção de Tremor) ---
// Checamos se a posição futura total (X e Y) é válida
var _c1 = position_meeting(bbox_left + _hspd, bbox_top + _vspd, _chao);
var _c2 = position_meeting(bbox_right + _hspd, bbox_top + _vspd, _chao);
var _c3 = position_meeting(bbox_left + _hspd, bbox_bottom + _vspd, _chao);
var _c4 = position_meeting(bbox_right + _hspd, bbox_bottom + _vspd, _chao);

// Se qualquer canto for sair do chão:
if !(_c1 && _c2 && _c3 && _c4) {
    // Em vez de só inverter, tentamos uma nova direção aleatória 
    // ou refletimos para longe da borda
    direction += 180 + irandom_range(-20, 20); 
    persegue_player = false; // Para de perseguir por um instante para não travar na borda
}

// O movimento real é feito automaticamente pelo GameMaker usando speed e direction