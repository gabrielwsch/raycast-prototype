if (imortal > 0) {
    // Desenha o player com "Blend Mode" Aditivo para brilhar
    gpu_set_blendmode(bm_add);
    
    // Desenha 3 versões levemente deslocadas para criar um efeito de "vibração"
    var shift = 2;
    draw_sprite_ext(sprite_index, image_index, x + shift, y, image_xscale, image_yscale, image_angle, c_white, 0.3);
    draw_sprite_ext(sprite_index, image_index, x - shift, y, image_xscale, image_yscale, image_angle, c_white, 0.3);
    
    gpu_set_blendmode(bm_normal);
}
draw_self();

// 2. Cálculo da Porcentagem (Regra de Três)
// Usamos clamp para garantir que o valor enviado à barra nunca saia de 0-100
var _porcentagem = (global.energy / obj_hud.p_energy_max) * 100;
_porcentagem = clamp(_porcentagem, 0, 100);


// Configurações da barra
var barra_largura = 50;
var barra_altura = 5;
var offset_y = 15; // Distância vertical acima do sprite

// Pegamos a largura do sprite para achar o meio dele
var meio_do_player = sprite_width / 2;

// Cálculos de posição baseados no Top-Left
var x1 = x + meio_do_player - (barra_largura / 2);
var y1 = y - offset_y - barra_altura;
var x2 = x1 + barra_largura;
var y2 = y1 + barra_altura;

// Desenha a barra de energia
// global.energy deve estar entre 0 e 100
draw_healthbar(x1, y1+5, x2 -3, y2+5, _porcentagem, c_black, #99CFFF, #99CFFF, 0, true, true);

// 1. Configura o alinhamento para o texto ficar centralizado no ponto X
draw_set_halign(fa_center);
draw_set_valign(fa_bottom); // Alinha pela base do texto
draw_set_font(fnt_hud);          // Usa a fonte padrão (ou troque pelo nome da sua fonte)
draw_set_color(c_black);    // Cor do texto

// 2. Define o nome (você pode trocar "Wolfgang" por uma variável depois)
var _nome_player = "Wolfgang"; 

// 3. Desenha o nome
// Usamos _meio_x para centralizar e (y1 - 5) para ficar um pouco acima da barra
// 0.5 fará o texto ficar com metade do tamanho original
var escala = 0.5; 

draw_text_transformed(x2 - 25, y1 + 3, _nome_player, escala, escala, 0);
// 4. SEMPRE resete o alinhamento para não quebrar outros textos do jogo
draw_set_halign(fa_left);
draw_set_valign(fa_top);