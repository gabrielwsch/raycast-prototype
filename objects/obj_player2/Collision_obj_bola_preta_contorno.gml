// Se colidir com inimigo
if (escudo_ativo) {
    // Bloqueou o dano!
    escudo_ativo = false;
    imortal = true;
    
    // Cancela o alarme que daria energia (pois foi atingido)
    alarm[2] = -1; 
    
    // Alarme 4: Tempo de Imortalidade conforme o nível
    var lvl = clamp(global.hab2_atual - 1, 0, 4);
    alarm[5] = tempo_imortal_niveis[lvl] * 60; 
    
    exit; // Sai do evento para não morrer
}

if (imortal) {
    exit; // Ignora a colisão se já estiver imortal
}

if (imortal1) {
    exit; // Ignora a colisão se já estiver imortal
}

// Se chegou aqui e não tem escudo nem imortalidade:
// [INSIRA AQUI SEU CÓDIGO DE MORTE DO PLAYER]
game_restart()