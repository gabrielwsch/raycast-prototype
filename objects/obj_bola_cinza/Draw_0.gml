// 1. Sincroniza a "tinta" do GameMaker com o alpha atual do objeto
draw_set_alpha(image_alpha);

// 2. Definições
var _raio = sprite_width / 2;
var _grossura = 2; 

// 3. Desenha o preenchimento (agora respeitará a transparência)
draw_set_color(#555555); 
draw_circle(x, y, _raio, false);

// 4. Desenha o contorno
draw_set_color(c_black); 
for (var i = 0; i < _grossura; i++) {
    draw_circle(x, y, _raio - i, true);
}

// 5. IMPORTANTE: Reseta o alpha para 1 para não deixar o resto do jogo transparente
draw_set_alpha(1);