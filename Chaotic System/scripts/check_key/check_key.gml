// _key est le numéro associé à la touche voulue: 0 l, 1 r, 2 u, 3 d, 4 z, 5 x, 6 r
function check_key(_key) {
	return global.inputs[0, _key] || global.inputs[1, _key] || global.inputs[2, _key] || global.inputs[3, _key];
}