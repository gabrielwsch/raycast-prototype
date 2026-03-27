var lvl = global.hab1_atual - 1;

// Configurações de Nível
rebates_restantes = [1, 1, 2, 2, 3][lvl];
red_tam = [0.10, 0.10, 0.15, 0.15, 0.25][lvl];
red_vel = [0.10, 0.13, 0.16, 0.19, 0.25][lvl];

// Controle de Estado
alvo_atual = noone;
timer_fase = 30;    // 0.5s tremendo
timer_extra = 21;   // 0.35s de debuff residual
primeiro_alvo = true;
estado = "tremendo"; 

// Memória do Inimigo (para restaurar sem mexer no código dele)
vel_original_inimigo = 0;
escala_original_x = 1;
escala_original_y = 1;

lista_atingidos = ds_list_create();

function buscar_inimigo_multiplicador(_bolinha) {
    var raio_busca = 140; 
    var mais_proximo = noone;
    var dist_min = raio_busca;
    
    // Alvos de ricochete: APENAS bolas cinzas
    with (obj_bola_cinza) {
        var d = point_distance(_bolinha.x, _bolinha.y, x, y);
        
        if (d < dist_min && ds_list_find_index(_bolinha.lista_atingidos, id) == -1) {
            // Checa se já tem uma bolinha vindo para este alvo
            var ocupado = false;
            with (obj_bolinha_hab) {
                if (id != _bolinha.id && alvo_atual == other.id) ocupado = true;
            }
            
            if (!ocupado) {
                dist_min = d;
                mais_proximo = id;
            }
        }
    }
    return mais_proximo;
}