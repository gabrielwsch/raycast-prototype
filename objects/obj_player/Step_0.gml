var _chao = [obj_chao, obj_chao_safe];
if (place_meeting(x, y, global.concluida_fase)){
	global.continuar_fase = 1
	mapa_concluido()
}

if(keyboard_check(vk_shift)){
	 vel = 5
} else vel = global.vel

// 1. Inputs
var _input_x = (keyboard_check(vk_right) || keyboard_check(ord("D"))) - (keyboard_check(vk_left) || keyboard_check(ord("A")));
var _input_y = (keyboard_check(vk_down) || keyboard_check(ord("S"))) - (keyboard_check(vk_up) || keyboard_check(ord("W")));

// 2. Escala Visual (Inverte o desenho sem mudar a BBOX real)
if (_input_x != 0) _dir_visual = sign(_input_x); 

// --- MOVIMENTO HORIZONTAL (X) ---
if (_input_x != 0) {
    repeat(abs( vel)) {
        var _prox_x = x + sign(_input_x);
        
        // Verifica se a sprite inteira ainda estaria no chão nesse próximo pixel
        // Usamos position_meeting nos 4 cantos para precisão absoluta
        var _c1 = position_meeting(bbox_left + sign(_input_x), bbox_top, _chao);
        var _c2 = position_meeting(bbox_right + sign(_input_x), bbox_top, _chao);
        var _c3 = position_meeting(bbox_left + sign(_input_x), bbox_bottom, _chao);
        var _c4 = position_meeting(bbox_right + sign(_input_x), bbox_bottom, _chao);
        
        if (_c1 && _c2 && _c3 && _c4) {
            x += sign(_input_x);
        } else {
            break; // Encostou no limite do chão, para o repeat
        }
    }
}

// --- MOVIMENTO VERTICAL (Y) ---
if (_input_y != 0) {
    repeat(abs( vel)) {
        var _prox_y = y + sign(_input_y);
        
        var _c1 = position_meeting(bbox_left, bbox_top + sign(_input_y), _chao);
        var _c2 = position_meeting(bbox_right, bbox_top + sign(_input_y), _chao);
        var _c3 = position_meeting(bbox_left, bbox_bottom + sign(_input_y), _chao);
        var _c4 = position_meeting(bbox_right, bbox_bottom + sign(_input_y), _chao);
        
        if (_c1 && _c2 && _c3 && _c4) {
            y += sign(_input_y);
        } else {
            break; // Encostou no limite do chão, para o repeat
        }
    }
}
var _vel_max =  vel;
var _raio_parada = 1;
var _raio_reducao = 320;

// 1. Ativar/Desativar com o clique do mouse (Botão Esquerdo)
if (mouse_check_button_pressed(mb_left)) {
    global.movendo_pelo_mouse = !global.movendo_pelo_mouse;
}

// 2. Só executa a lógica se estiver ativado
if (global.movendo_pelo_mouse) {
    var _dist = point_distance(x, y, mouse_x, mouse_y);
    var _dir = point_direction(x, y, mouse_x, mouse_y);

    // Cálculo da Velocidade Adaptativa
    var _vel_atual = 0;
    if (_dist > _raio_parada) {
        _vel_atual = min(_vel_max, (_dist / _raio_reducao) * _vel_max);
    }

    var _hspd = lengthdir_x(_vel_atual, _dir);
    var _vspd = lengthdir_y(_vel_atual, _dir);

    if (_hspd != 0) _dir_visual = sign(_hspd);

    // --- MOVIMENTO X (Pixel a Pixel) ---
    repeat(abs(_hspd)) {
        var _sign_x = sign(_hspd);
        if (position_meeting(bbox_left + _sign_x, bbox_top, _chao) && 
            position_meeting(bbox_right + _sign_x, bbox_top, _chao) && 
            position_meeting(bbox_left + _sign_x, bbox_bottom, _chao) && 
            position_meeting(bbox_right + _sign_x, bbox_bottom, _chao)) {
            x += _sign_x;
        } else { break; }
    }

    // --- MOVIMENTO Y (Pixel a Pixel) ---
    repeat(abs(_vspd)) {
        var _sign_y = sign(_vspd);
        if (position_meeting(bbox_left, bbox_top + _sign_y, _chao) && 
            position_meeting(bbox_right, bbox_top + _sign_y, _chao) && 
            position_meeting(bbox_left, bbox_bottom + _sign_y, _chao) && 
            position_meeting(bbox_right, bbox_bottom + _sign_y, _chao)) {
            y += _sign_y;
        } else { break; }
    }
}

// --- 1. CONTROLE DE IMORTALIDADE (PROTEÇÃO ATIVA) ---
if (imortal) {
    timer_imortal--;
    image_alpha = 0.4; 
    if (timer_imortal <= 0) {
        imortal = false;
        timer_intervalo = tempo_intervalo_total; // Ativa o hiato de 1s
    }
}

// --- 2. CONTROLE DO INTERVALO (VULNERABILIDADE) ---
if (timer_intervalo > 0) {
    timer_intervalo--;
    image_alpha = 0.85; // Alpha de perigo entre cargas
} 

// --- 3. ESTADO NORMAL ---
if (!imortal && timer_intervalo <= 0) {
    image_alpha = 1.0;
}

// --- 4. SISTEMA DE RECARGA (O CORAÇÃO DO PROBLEMA) ---
// Esta lógica deve estar fora de qualquer outro IF para rodar sempre
if (cargas_atuais < cargas_max) {
    timer_recuperacao++; // Incrementa o tempo
    
    if (timer_recuperacao >= tempo_recuperacao_total) {
        cargas_atuais += 1;
        timer_recuperacao = 0; // Reseta para começar a carregar a próxima
    }
} else {
    timer_recuperacao = 0; // Garante que o timer esteja zerado se estiver cheio
}

// --- 5. APLICAÇÃO DAS CORES ---
if (cargas_atuais == 2) image_blend = #4C0000;      // Super Escuro
else if (cargas_atuais == 1) image_blend = #B21111; // Escuro Médio
else image_blend = #FFCCCC;                         // Muito Claro