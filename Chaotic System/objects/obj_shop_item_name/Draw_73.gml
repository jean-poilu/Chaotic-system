draw_set_halign(fa_center);
draw_set_valign(fa_middle);

x = obj_shop_menu.mouse.x + 5;
y = obj_shop_menu.mouse.y + 1;

draw_self();
draw_text_transformed(x + 95 + 3, y - 16 + 3, title, 1, 1, 0);