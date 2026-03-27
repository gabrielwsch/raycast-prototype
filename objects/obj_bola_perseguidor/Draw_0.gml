draw_set_alpha(image_alpha);

var _raio = sprite_width / 2;
var _grossura = 2; 

// Se estiver perseguindo, fica vermelho, senão cinza escuro
var _cor_corpo = persegue_player ? #E54476 : #B24B6B;

draw_set_color(_cor_corpo); 
draw_circle(x, y, _raio, false);

draw_set_color(c_black); 
for (var i = 0; i < _grossura; i++) {
    draw_circle(x, y, _raio - i, true);
}

draw_set_alpha(1);