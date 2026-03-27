if (!instance_exists(alvo_atual)) { instance_destroy(); exit; }

var is_preta = (alvo_atual.object_index == obj_bola_preta_contorno);
var _vel_preto = 0
// --- ESTADO 1: TREMENDO NO CENTRO ---
if (estado == "tremendo") {
    x = alvo_atual.x + irandom_range(-2, 2);
    y = alvo_atual.y + irandom_range(-2, 2);

    if (timer_fase == 30) {
        if (!variable_instance_exists(alvo_atual, "minha_vel_base")) {
            alvo_atual.minha_vel_base = alvo_atual.speed;
        }

        if alvo_atual != obj_bola_preta_contorno alvo_atual.speed = 0; // Sempre paralisa no impacto
        var red = is_preta ? (red_tam / 2) : red_tam;
        alvo_atual.image_xscale = 1 - red;
        alvo_atual.image_yscale = 1 - red;
        
        if (is_preta) {
			image_blend = c_orange; // Bolinha de cor diferente na preta
		}
    }

    timer_fase--;
    if (timer_fase <= 0) estado = "extra";
}

// --- ESTADO 2: DEBUFF EXTRA E FINALIZAÇÃO ---
if (estado == "extra") {
    visible = false;
    timer_extra--;

    if (timer_extra <= 0) {
        // Restaurar Inimigo
        if (instance_exists(alvo_atual)) {
            alvo_atual.image_xscale = 1;
            alvo_atual.image_yscale = 1;
            alvo_atual.speed = alvo_atual.minha_vel_base;
        }

        // --- LÓGICA DE FINALIZAÇÃO ---
        if (is_preta) {
            // Se o alvo for bola preta, ela morre sem ricochetear ou criar outras
            instance_destroy();
        } 
        else if (rebates_restantes > 0) {
            // Ricochete normal para bolas cinzas
            ds_list_add(lista_atingidos, alvo_atual);
            repeat(2) {
                var prox = buscar_inimigo_multiplicador(id); 
                if (prox != noone) {
                    var nova_b = instance_create_layer(x, y, "hab", obj_bolinha_hab);
                    nova_b.alvo_atual = prox;
                    nova_b.rebates_restantes = rebates_restantes - 1;
                    nova_b.primeiro_alvo = false;
                    ds_list_copy(nova_b.lista_atingidos, lista_atingidos);
                }
            }
            instance_destroy();
        } 
        else {
            instance_destroy();
        }
    }
}