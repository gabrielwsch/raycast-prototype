var _chao = obj_chao
var _vel = vel;
switch (estado) {
    case 0: // DIREITA
        // Checa se há chão à direita na altura atual
        if (position_meeting(bbox_right + _vel, y, _chao)) {
            x += _vel;
        } else {
            // Encosta no limite direito e muda para baixo
            while(position_meeting(bbox_right + 1, y, _chao)) x += 1;
            estado = 1;
        }
        break;

    case 1: // BAIXO
        // Checa se há chão abaixo na posição X atual
        if (position_meeting(x, bbox_bottom + _vel, _chao)) {
            y += _vel;
        } else {
            // Encosta no limite inferior e muda para esquerda
            while(position_meeting(x, bbox_bottom + 1, _chao)) y += 1;
            estado = 2;
        }
        break;

    case 2: // ESQUERDA
        // Checa se há chão à esquerda na altura atual
        if (position_meeting(bbox_left - _vel, y, _chao)) {
            x -= _vel;
        } else {
            // Encosta no limite esquerdo e muda para cima
            while(position_meeting(bbox_left - 1, y, _chao)) x -= 1;
            estado = 3;
        }
        break;

    case 3: // CIMA
        // Checa se há chão acima na posição X atual
        if (position_meeting(x, bbox_top - _vel, _chao)) {
            y -= _vel;
        } else {
            // Encosta no limite superior e muda para direita
            while(position_meeting(x, bbox_top - 1, _chao)) y -= 1;
            estado = 0;
        }
        break;
}