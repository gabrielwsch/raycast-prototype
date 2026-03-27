// Lógica para AVANÇAR
if (id == global.concluida_fase) {
    if (global.fase_atual < global.fase_maxima) {
        global.fase_atual += 1;
        global.vindo_de_tras = false; 
        obj_control.proxima_fase_carregada = false; 
    } else {
        show_message("Fim das 40 fases!");
        game_restart();
    }
} 

// Lógica para VOLTAR
else if (variable_global_exists("voltar_fase") && id == global.voltar_fase) {
    if (global.fase_atual > 1) {
        global.fase_atual -= 1;
        global.vindo_de_tras = true; 
        obj_control.proxima_fase_carregada = false;
    }
}