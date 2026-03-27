if global.hab1_atual > 0 {
	if (imortal) exit; // Se estiver no brilho da imortalidade, ignore o inimigo

	if (cargas_atuais > 0 && timer_intervalo <= 0) {
	    // USA UMA CARGA
	    cargas_atuais -= 1;
	    imortal = true;
	    timer_imortal = tempo_imortal_total;
		timer_recuperacao = 0;
    
	    // NOTA: Removi o reset do timer_recuperacao daqui. 
	    // Assim, se você já esperou 7 segundos, falta apenas 1 para recuperar, 
	    // mesmo após usar a habilidade.
	} 
	else {
	    // Se bater no intervalo (Alpha 0.85) ou sem cargas: MORRE
	    game_restart();
	}
}else game_restart()