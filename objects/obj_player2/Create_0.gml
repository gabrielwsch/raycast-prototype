_dir_visual = 1; 
vel = global.vel
image_blend = #A5C1CC
// --- Variáveis Hab 2 ---
escudo_ativo = false;
imortal = false;
imortal1 = false;
cooldown_hab2 = false;
bolas_ignoradas = ds_list_create();
// Escalonamento de imortalidade por nível (1 a 5)
tempo_imortal_niveis = [0.4, 0.5, 0.6, 0.7, 0.9];