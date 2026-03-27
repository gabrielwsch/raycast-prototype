_dir_visual = undefined

_dir_visual = 1; // Para o espelhamento do sprite
global.vel = 17;
vel = global.vel
global.hab1_max = 1
global.hab2 = false
// Mecânica de Imortalidade e Cargas
// Cargas e Estados
cargas_max = 2;
cargas_atuais = cargas_max;
imortal = false;
// Timers (convertidos para frames)
tempo_imortal_total = 1.0 * room_speed;
timer_imortal = 0;

tempo_recuperacao_total = 10 * room_speed;
timer_recuperacao = 0;

tempo_intervalo_total = 1.0 * room_speed; // Intervalo obrigatório de 1s
timer_intervalo = 0;

// Cores para o sistema de cargas
// 2 cargas: c_maroon (vermelho escuro)
// 1 carga: c_red (vermelho médio)
// 0 cargas: c_white ou um vermelho bem claro