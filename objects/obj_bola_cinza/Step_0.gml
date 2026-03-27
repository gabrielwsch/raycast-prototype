
var _chao = obj_chao

// 1. Calculamos o movimento desejado para este frame
var _hspd = lengthdir_x(speed, direction);
var _vspd = lengthdir_y(speed, direction);

// --- CHECAGEM NO EIXO X ---
// Simulamos se o movimento em X tiraria qualquer canto do chão
var _x_futuro = x + _hspd;
var _c1x = position_meeting(bbox_left + _hspd, bbox_top, _chao);
var _c2x = position_meeting(bbox_right + _hspd, bbox_top, _chao);
var _c3x = position_meeting(bbox_left + _hspd, bbox_bottom, _chao);
var _c4x = position_meeting(bbox_right + _hspd, bbox_bottom, _chao);

if !(_c1x && _c2x && _c3x && _c4x) {
    // Se sair do chão em X, invertemos a direção horizontal (reflexão)
    direction = point_direction(0, 0, -_hspd, _vspd);
}

// --- CHECAGEM NO EIXO Y ---
// Recalculamos o _vspd com base na possível nova direção do X
_vspd = lengthdir_y(speed, direction); 

var _c1y = position_meeting(bbox_left, bbox_top + _vspd, _chao);
var _c2y = position_meeting(bbox_right, bbox_top + _vspd, _chao);
var _c3y = position_meeting(bbox_left, bbox_bottom + _vspd, _chao);
var _c4y = position_meeting(bbox_right, bbox_bottom + _vspd, _chao);

if !(_c1y && _c2y && _c3y && _c4y) {
    // Se sair do chão em Y, invertemos a direção vertical (reflexão)
    direction = point_direction(0, 0, lengthdir_x(speed, direction), -_vspd);
}

// O movimento agora é processado automaticamente pelo GameMaker (speed/direction)