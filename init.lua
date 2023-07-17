local image_name = minetest.settings:get("splash.image") or "logo.png"
local splash = {
	player = {},
	image = {
		name = image_name,
		scale = minetest.settings:get("splash.scale") or 4,
	},
	sound = minetest.settings:get("splash.sound") or "splash_self_join",
}

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	splash.player[name] = player:hud_add({
		hud_elem_type = "image",
		text = splash.image.name,
		position = { x = 0.5, y = 0.3 },
		scale = { x = splash.image.scale, y = splash.image.scale },
	})

	if splash.sound then
		minetest.sound_play(splash.sound, {
			to_player = name,
			gain = 1.0,
		})
	end

	minetest.after(4, function()
		player:hud_remove(splash.player[name])
	end)
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	player:hud_remove(splash.player[name])
end)

