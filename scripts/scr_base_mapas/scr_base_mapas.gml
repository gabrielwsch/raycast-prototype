function criar_mapa_simples(qtd1, qtd2, inm, qtd3, qtd4, inm2){
    var _yysafe = 428;
    var _xxdistance_colision = 700;
    repeat(8){
        instance_create_layer(0 +_xxdistance_colision, _yysafe, "chaos", obj_chao_safe);
        _yysafe += 64;
    }
    instance_create_layer(320 + _xxdistance_colision, 428, "chaos", obj_chao);
    instance_create_layer(0 + _xxdistance_colision, 428, "trocaf", obj_troca_fase);
    instance_create_layer(0 + _xxdistance_colision + 64, 428, "trocaf", obj_troca_fase02);
    instance_create_layer(0 + _xxdistance_colision + 64, 428 + 448, "trocaf", obj_troca_fase02);
    
    var _spawn_x = 160 + 700; 
    var _spawn_y = 716;
    instance_create_layer(_spawn_x, _spawn_y, "Instances", obj_player2);
	instance_create_layer(_spawn_x, _spawn_y, "hab", obj_hat01)
    
    var _xxdistance_colision2 = 4764;
    var _yysafe2 = 428;
    repeat(8){
        instance_create_layer(0 +_xxdistance_colision2, _yysafe2, "chaos", obj_chao_safe);
        _yysafe2 += 64;
    }
    global.concluida_fase = instance_create_layer(256 + _xxdistance_colision2, 428, "trocaf", obj_troca_fase);
	global.concluida_fase.image_blend = #6A2D99
    // 1. Bolas Cinzas Normais
    var _qtd_normais = irandom_range(qtd1, qtd2);
    logic_spawn_inimigo(obj_chao, _qtd_normais, inm);

    // 2. Bolas Cinzas Rápidas (Mesma lógica de nascimento)
    logic_spawn_inimigo(obj_chao, qtd4, inm2);

    // 3. Bolas Pretas (Perímetro)
    logic_spawn_perimetro(obj_chao, qtd3);
	
	var _qtd_xp = irandom_range(10, 35);
    logic_spawn_inimigo(obj_chao, _qtd_xp, obj_xp_simples, "trocaf");
}

function criar_mapa_continuation(qtd1, qtd2, inm, qtd3, qtd4, inm2){
    var _yysafe = 428;
    var _xxdistance_colision = 700;
    repeat(8){
        instance_create_layer(0 +_xxdistance_colision, _yysafe, "chaos", obj_chao_safe);
        _yysafe += 64;
    }
    instance_create_layer(320 + _xxdistance_colision, 428, "chaos", obj_chao);
    global.voltar_fase = instance_create_layer(0 + _xxdistance_colision, 428, "trocaf", obj_troca_fase);
    global.voltar_fase.image_blend = #6A2D99
    var _spawn_x, _spawn_y;
    if (global.vindo_de_tras == false) {
        _spawn_x = 160 + 700; _spawn_y = 716;
    } else {
        _spawn_x = 4764 + 90; _spawn_y = 428 * 1.6; 
    }
	
    instance_create_layer(_spawn_x, _spawn_y, "Instances", obj_player2);
    instance_create_layer(_spawn_x, _spawn_y, "hab", obj_hat01)
    var _xxdistance_colision2 = 4764;
    var _yysafe2 = 428;
    repeat(8){
        instance_create_layer(0 +_xxdistance_colision2, _yysafe2, "chaos", obj_chao_safe);
        _yysafe2 += 64;
    }
    global.concluida_fase = instance_create_layer(256 + _xxdistance_colision2, 428, "trocaf", obj_troca_fase);
	global.concluida_fase.image_blend = #6A2D99
    // 1. Bolas Cinzas Normais
    var _qtd_normais = irandom_range(qtd1, qtd2);
    logic_spawn_inimigo(obj_chao, _qtd_normais, inm);

    // 2. Bolas Cinzas Rápidas
    logic_spawn_inimigo(obj_chao, qtd4, inm2);

    // 3. Bolas Pretas (Perímetro)
    logic_spawn_perimetro(obj_chao, qtd3);
	
	// Spawn de XP Aleatório (entre 10 e 35)
	var _qtd_xp = irandom_range(10, 35);
	logic_spawn_inimigo(obj_chao, _qtd_xp, obj_xp_simples, "trocaf");
}

// --- FUNÇÕES AUXILIARES PARA LIMPAR O CÓDIGO ---

function logic_spawn_inimigo(_tipo_chao, _qtd, _obj, _layer = "Instances") {
    repeat(_qtd) {
        var _total = instance_number(_tipo_chao);
        if (_total > 0) {
            var _inst = instance_find(_tipo_chao, irandom(_total - 1));
            var _margem = 32;
            var _x_min = _inst.bbox_left + _margem;
            var _x_max = _inst.bbox_right - _margem;
            var _y_min = _inst.bbox_top + _margem;
            var _y_max = _inst.bbox_bottom - _margem;
            
            if (_x_max > _x_min && _y_max > _y_min) {
                instance_create_layer(random_range(_x_min, _x_max), random_range(_y_min, _y_max), _layer, _obj);
            }
        }
    }
}

function logic_spawn_perimetro(_tipo_chao, _qtd) {
    var _inst = instance_find(_tipo_chao, 0);
    if (_inst != noone && _qtd > 0) {
        var _spr = spr_bola_preta_contorno;
        var _meio_w = sprite_get_width(_spr) / 2;
        var _meio_h = sprite_get_height(_spr) / 2;
        
        var _w = _inst.bbox_right - _inst.bbox_left;
        var _h = _inst.bbox_bottom - _inst.bbox_top;
        var _perimetro = (_w + _h) * 2;
        var _espacamento = _perimetro / _qtd;

        for (var i = 0; i < _qtd; i++) {
            var _dist = i * _espacamento;
            var _sx, _sy, _est;

            if (_dist < _w) { // CIMA
                _sx = _inst.bbox_left + _dist;
                _sy = _inst.bbox_top + _meio_h; 
                _est = 0;
            } 
            else if (_dist < _w + _h) { // DIREITA
                _sx = _inst.bbox_right - _meio_w;
                _sy = _inst.bbox_top + (_dist - _w);
                _est = 1;
            } 
            else if (_dist < _w * 2 + _h) { // BAIXO
                _sx = _inst.bbox_right - (_dist - (_w + _h));
                _sy = _inst.bbox_bottom - _meio_h;
                _est = 2;
            } 
            else { // ESQUERDA
                _sx = _inst.bbox_left + _meio_w;
                _sy = _inst.bbox_bottom - (_dist - (_w * 2 + _h));
                _est = 3;
            }
            
            var _n = instance_create_layer(_sx, _sy, "Instances", obj_bola_preta_contorno);
            _n.estado = _est;
        }
    }
}

function mapa_concluido(){
	with (all) {
	    if (!persistent) {
	        instance_destroy();
	    }
	}
	global.p_xp = 100
}

///////////////////////////////////////////////////////////////////////////////////////////////

// --- 1. O ARQUITETO ---
function build_sector_base(_is_continuation, _enemy_logic_function, _bg_color = #191919) {
    mapa_concluido(); 
    
    // Configuração do Fundo
    var _lay_id = layer_get_id("Background");
    var _back_id = layer_background_get_id(_lay_id);
    layer_background_blend(_back_id, _bg_color);

    var _x_start = 700;
    var _x_end = 4764;
    var _yy_base = 428;

    // Criar Chão Safe e Tonalidade
    var _yy = _yy_base;
    repeat(8) {
        var _s1 = instance_create_layer(_x_start, _yy, "chaos", obj_chao_safe);
        var _s2 = instance_create_layer(_x_end, _yy, "chaos", obj_chao_safe);
        _yy += 64;
    }

    var _chao = instance_create_layer(_x_start + 320, _yy_base, "chaos", obj_chao);

    // --- BORDAS ESPECIAIS DA FASE 1 (Seleção de Mapas) ---
    if (global.fase_atual == 1) {
        // Cria as bordas extras para trocar de setor manualmente
        instance_create_layer(_x_start + 64, _yy_base, "trocaf", obj_troca_fase02);
        instance_create_layer(_x_start + 64, _yy_base + 448, "trocaf", obj_troca_fase02);
    }

    // Lógica de Spawn do Player
    var _spawn_x, _spawn_y;
    if (!_is_continuation) {
        // Início absoluto
        instance_create_layer(_x_start, _yy_base, "trocaf", obj_troca_fase);
        _spawn_x = _x_start + 160; 
        _spawn_y = 716;
    } else {
        // Continuação do mapa
        global.voltar_fase = instance_create_layer(_x_start, _yy_base, "trocaf", obj_troca_fase);
        global.voltar_fase.image_blend = #6A2D99;
        _spawn_x = (global.vindo_de_tras) ? (_x_end + 90) : (_x_start + 160);
        _spawn_y = (global.vindo_de_tras) ? (_yy_base * 1.6) : 716;
    }

    var _p = instance_create_layer(_spawn_x, _spawn_y, "Instances", obj_player2);
    instance_create_layer(_p.x, _p.y, "hab", obj_hat01);

    // Saída padrão
    global.concluida_fase = instance_create_layer(_x_end + 256, _yy_base, "trocaf", obj_troca_fase);
    global.concluida_fase.image_blend = #6A2D99;

    // Executa inimigos
    if (script_exists(_enemy_logic_function)) {
        _enemy_logic_function(_chao);
    }
    
    logic_spawn_inimigo(obj_chao, irandom_range(10, 35), obj_xp_simples, "trocaf");
}

// --- 2. AS RECEITAS ---
function sector_initial_logic(_chao_inst) {
    var _f = global.fase_atual;
    var _min = 8 + floor(_f * 2.7);
    var _max = 12 + floor(_f * 3.1);
    global.chao_color = #FFE0FF
    logic_spawn_inimigo(obj_chao, irandom_range(_min, _max), obj_bola_cinza);
    logic_spawn_perimetro(obj_chao, floor(_f / 5) * 4);
    
    if (_f >= 5) {
        var _qtd_r = floor(_f / 5) * 2;
        logic_spawn_inimigo(obj_chao, _qtd_r, obj_bola_cinza_rapida);
    }
    
    if (_f % 10 == 0) {
        var _qtd_g = (_f >= 40) ? 5 : 3;
        repeat(_qtd_g) {
            var _gx = random_range(_chao_inst.bbox_left + 300, _chao_inst.bbox_right - 300);
            var _gy = random_range(_chao_inst.bbox_top + 300, _chao_inst.bbox_bottom - 300);
            instance_create_layer(_gx, _gy, "Instances", obj_bola_cinza_gigante);
        }
    }
}

function sector_two_logic(_chao_inst) {
    var _f = global.fase_atual;
    var _min = 3 + floor(_f * 4);
    var _max = 5 + floor(_f * 5);
	var _lay_id = layer_get_id("Background");
    var _back_id = layer_background_get_id(_lay_id);
    layer_background_blend(_back_id, #4C1627)
	global.chao_color = c_white
    logic_spawn_inimigo(obj_chao, irandom_range(_min, _max), obj_bola_perseguidor);
    logic_spawn_perimetro(obj_chao, floor(_f / 5) * 4);
    
    if (_f >= 5) {
        var _qtd_r = floor(_f / 5) * 2;
        logic_spawn_inimigo(obj_chao, _qtd_r, obj_bola_cinza_rapida);
    }
    
    if (_f % 10 == 0) {
        var _qtd_g = (_f >= 40) ? 5 : 3;
        repeat(_qtd_g) {
            var _gx = random_range(_chao_inst.bbox_left + 300, _chao_inst.bbox_right - 300);
            var _gy = random_range(_chao_inst.bbox_top + 300, _chao_inst.bbox_bottom - 300);
            instance_create_layer(_gx, _gy, "Instances", obj_bola_cinza_gigante);
        }
    }
}