// --- Create Event ---
tempo_room = 0;
map_name = "Initial Sector";
global.vel = 5
global.vel_max = 17
global.regen_max = 7
global.energy_max_level = 300
global.energy = 0
global.fase_atual = 1;
global.fase_maxima = 40;
global.vindo_de_tras = false; 
global.receita = [sector_initial_logic, sector_two_logic]
global.receita_atual = 0
global.chao_color = c_white
global.movendo_pelo_mouse = false;
proxima_fase_carregada = false; 

function gerar_proxima_fase() {
    global.concluida_fase = noone;
    global.voltar_fase = noone;

    // 1. ESCOLHA DO MAPA (SETOR)
    // Aqui você decide qual "Receita" usar baseado na fase
	if global.receita_atual > array_length(global.receita) - 1 global.receita_atual = 0
    var _receita_para_usar = global.receita[global.receita_atual]; 

    // 2. CHAMA O ARQUITETO
    // build_sector_base( é_continuação?, qual_receita? )
    var _eh_continuidade = (global.fase_atual > 1);
    build_sector_base(_eh_continuidade, _receita_para_usar);

    proxima_fase_carregada = true;
}