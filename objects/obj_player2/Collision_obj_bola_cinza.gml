// --- 1. FILTRO DE SEGURANÇA IMEDIATO ---
// Se eu estiver imortal (Hab1 ou Hab2), ignora.
if (imortal || imortal1) exit;

// Se esta bola específica estiver na lista de ignorados, ignora.
if (ds_list_find_index(bolas_ignoradas, other.id) != -1) exit;

// Se o escudo estiver ativo, consome o escudo e me torna imortal.
if (escudo_ativo) {
    escudo_ativo = false;
    imortal = true;
    alarm[2] = -1; 
    var lvl_h2 = clamp(global.hab2_atual - 1, 0, 4);
    alarm[5] = [30, 30, 40, 40, 60][lvl_h2];
    exit;
}
if global.hab1_atual > 0 {
	// --- 2. TENTAR ATIVAR HAB 1 (CONTRA-ATAQUE) ---
	if (alarm[0] <= 0 && global.energy >= 30) {
	    global.energy -= 30;
	    alarm[0] = 30; 
    
	    // Torna o player imortal imediatamente para este frame
	    imortal1 = true;
	    alarm[4] = 3;  
    
	    vel += 3;
	    alarm[1] = 120;
    
	    var inimigo_hit = other.id; 
    
	    // ADICIONA NA LISTA ANTES DE QUALQUER OUTRA COISA
	    ds_list_add(bolas_ignoradas, inimigo_hit);
    
	    // Define as variáveis de controle dentro da bola (via Player)
	    with(inimigo_hit) {
	        timer_inofensivo = 90; // 1.5s
	        original_alpha = image_alpha;
	        image_alpha = 0.4;
	    }
    
	    // Lógica das Bolinhas Hab (Ricochete)
	    var lvl = global.hab1_atual - 1;
	    var qtd = [2, 3, 4, 5, 7][lvl];
	    var lista_dispersar = ds_list_create();
	    collision_circle_list(x, y, 140, obj_bola_cinza, false, true, lista_dispersar, true);
    
	    for (var i = 0; i < qtd; i++) {
	        var alvo_final = (i < ds_list_size(lista_dispersar)) ? lista_dispersar[| i] : inimigo_hit;
	        var b = instance_create_layer(alvo_final.x, alvo_final.y, "hab", obj_bolinha_hab);
	        b.alvo_atual = alvo_final;
	        b.primeiro_alvo = true;
	    }
	    ds_list_destroy(lista_dispersar);
    
	    exit; // Ativou a habilidade com sucesso, interrompe o evento aqui.
	}
}
// --- 3. SE CHEGOU AQUI, MORREU ---
game_restart();