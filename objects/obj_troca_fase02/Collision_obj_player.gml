// Colisão do Player com obj_troca_fase02
global.receita_atual += 1 
global.fase_atual = 1;
obj_control.proxima_fase_carregada = false;
room_restart(); // Isso vai disparar o gerar_proxima_fase() novamente