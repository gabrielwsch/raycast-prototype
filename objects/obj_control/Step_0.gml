if (proxima_fase_carregada == false) {
    gerar_proxima_fase();
}

// Incrementa o tempo se o mapa estiver carregado
if (proxima_fase_carregada) {
    tempo_room += 1 / 60;
}

// Reset do tempo quando a flag de nova fase for ativada
if (proxima_fase_carregada == false) {
    tempo_room = 0;
}