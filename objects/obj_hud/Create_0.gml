// Cores baseadas na imagem e no seu pedido
cor_fundo = make_color_rgb(100, 50, 150); // Roxo (ajuste o alpha no draw)
cor_texto_rotulo = c_silver;
cor_texto_valor = c_white;
cor_xp = make_color_rgb(0, 255, 0); // Verde vibrante da imagem
alarme = 0
// Dados (Substitua pelas variáveis do seu player)
p_xp_percent = 0; // 0 a 1 (65%)
p_points = 150
// Habilidades
// Stats do Player
p_speed = global.vel;
p_speed_max = global.vel_max
p_energy_max = 50;
global.energy = p_energy_max;
p_energy_max_level = global.energy_max_level
p_regen = 1;
p_regen_max = global.regen_max
global.hab1 = true
global.hab2 = true
global.p_level = 0;
global.p_xp = 0; // 0 a 100
alarm[0] = 60 / p_regen
// Habilidades
global.hab1_max = 5;
global.hab1_atual = 0; // Bloqueada (0 círculos cheios)
global.hab2_max = 5;
global.hab2_atual = 0; // Ativa

// Stats do Player


