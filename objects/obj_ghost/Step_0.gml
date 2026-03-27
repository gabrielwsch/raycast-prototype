// Faz o efeito de fade out
image_alpha -= alpha_speed;

if (image_alpha <= 0) {
    instance_destroy();
}