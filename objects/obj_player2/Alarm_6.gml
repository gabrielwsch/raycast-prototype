// Esse alarme serve como garantia caso o Step não limpe
var pos = ds_list_find_index(bolas_ignoradas, id_para_limpar);
if (pos != -1) ds_list_delete(bolas_ignoradas, pos);