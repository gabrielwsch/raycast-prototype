var _chao = [obj_chao, obj_chao_safe];
if (place_meeting(x, y, global.concluida_fase)){
	global.continuar_fase = 1
	mapa_concluido()
}
// Gerencia o alpha das bolas ignoradas e remove se o timer acabar
// No Step do obj_player2

// Criar um rastro a cada 3 frames se a armadura estiver ativa


for (var i = 0; i < ds_list_size(bolas_ignoradas); i++) {
    var _id = bolas_ignoradas[| i];
    if (instance_exists(_id)) {
        if (variable_instance_exists(_id, "timer_inofensivo")) {
            _id.timer_inofensivo--;
            if (_id.timer_inofensivo <= 0) {
                _id.image_alpha = _id.original_alpha;
                ds_list_delete(bolas_ignoradas, i);
                i--;
            }
        }
    } else {
        // Se a bola sumiu do jogo, remove da lista
        ds_list_delete(bolas_ignoradas, i);
        i--;
    }
}
// Cooldown e Energy check
// Raio de ativação curto (ex: 60 pixels)

if global.hab2_atual > 0 {
	// --- Ativação da Hab 2 ---
	if (keyboard_check_pressed(ord("X")) && !cooldown_hab2 && global.energy >= 40) {
	    global.energy -= 40;
	    escudo_ativo = true;
	    cooldown_hab2 = true;
    
	    // Alarme 2: Duração do escudo (3 segundos)
	    alarm[2] = 180; 
    
	    // Alarme 3: Cooldown da habilidade (5 segundos)
	    alarm[3] = 500; 
	}

	// Lógica Visual do Escudo (Opcional: mudar cor ou alpha)
	if (escudo_ativo) {
		    // Cria o rastro a cada 4 frames (ajuste para mais ou menos rastro)
		if (get_timer() % 4 == 0) {
		    var ghost = instance_create_depth(x, y, depth + 1, obj_ghost);
        
		    // Copia a aparência atual do player
		    ghost.sprite_index = sprite_index;
		    ghost.image_index = image_index;
		    ghost.image_xscale = image_xscale;
		    ghost.image_yscale = image_yscale;
		    ghost.image_angle  = image_angle;
			image_blend = #A5A6CC
		    // Define a cor e a transparência inicial
		    ghost.image_blend = #A5A6CC; // Ou a cor da sua armadura
		    ghost.image_alpha = 0.6;
		}
	} else if (imortal) {
	    image_blend = c_black;
	    image_alpha = 0.2; // Fica transparente enquanto imortal
	} else {
	    image_blend = #A5C1CC
	    image_alpha = 1;
	}
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