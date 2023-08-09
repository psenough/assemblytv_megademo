
-- bank switch mask mapping for the sync function
TILES   = 1<<0 -- 1
SPRITES = 1<<1 -- 2
MAP     = 1<<2 -- 4
SFX     = 1<<3 -- 8
MUSIC   = 1<<4 -- 16
PALETTE = 1<<5 -- 32
FLAGS   = 1<<6 -- 64
SCREEN  = 1<<7 -- 128

_track = 0
_pattern = 0
_row = 0
_t=0

musicplaying = false
current_bank_id = 0
current_track_id = 0

-- jumpstart somewhere, default should be 1
-- because indexes for arrays in lua start in 1 instead of 0 lol
current_scene_id = 1

scenes = {
	{
		init  = testcard_init,
		frame = testcard,
		bdr   = no_fn,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 14
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 0
	},{
		init  = cows_cctv_init,
		frame = cows_cctv,
		bdr   = no_fn,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 2
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 0
	},{
		init  = birds_cctv_init,
		frame = birds_cctv,
		bdr   = no_fn,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 4
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 0
	},{
		init  = scientist_init,
		frame = scientist,
		bdr   = no_fn,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 1,
		pattern_start = 3
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = SFX | MUSIC,
		track_start = 4,
		pattern_start = 0
	},{
		init  = hesburger_init,
		frame = hesburger,
		bdr   = no_fn,
		bank_switch = 1,
		bank_switch_mask = SFX | MUSIC,
		track_start = 5,
		pattern_start = 0
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 0
	},{
		init  = hurricane_init,
		frame = hurricane,
		bdr   = no_fn,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 6
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 0
	},{
		init  = scientist_init2,
		frame = scientist,
		bdr   = no_fn,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 1,
		pattern_start = 3
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = SFX | MUSIC,
		track_start = 4,
		pattern_start = 0
	},{
		init  = muffi_init,
		frame = muffi,
		bdr   = no_fn,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 1,
		pattern_start = 14
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 0
	},{
		init  = birds_cctv_init,
		frame = birds_cctv,
		bdr   = no_fn,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 4
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 0
	},{
		init  = scientist_init3,
		frame = scientist,
		bdr   = no_fn,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 1,
		pattern_start = 3
	},{
		init  = qrwx_init,
		frame = qrwx_1,
		bdr   = qrwx_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 0,
		pattern_start = 0
	},{
		init  = qrwx_init,
		frame = qrwx_2,
		bdr   = qrwx_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 0,
		pattern_start = 2
	},{
		init  = qrwx_init,
		frame = qrwx_3,
		bdr   = qrwx_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 0,
		pattern_start = 4
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 0
	},{
		init  = title_screen_init,
		frame = title_screen,
		bdr   = no_fn,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 0,
		pattern_start = 12	
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 0	
	},{
		init  = kaaal_init,
		frame = kaaal,
		bdr   = no_fn,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 7,
		pattern_start = 0
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = SFX | MUSIC,
		track_start = 4,
		pattern_start = 0
	},{
		init  = nooon_init,
		frame = nooon,
		bdr   = no_fn,
		bank_switch = 2,
		bank_switch_mask = SFX | MUSIC,
		track_start = 0,
		pattern_start = 10
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = TILES | SPRITES | PALETTE | SFX | MUSIC,
		track_start = 4,
		pattern_start = 0
	},{
		init  = saint_init,
		frame = saint,
		bdr   = no_fn,
		bank_switch = 2,
		bank_switch_mask = TILES | SPRITES | PALETTE | SFX | MUSIC,
		track_start = 1,
		pattern_start = 3
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = TILES | SPRITES | PALETTE | SFX | MUSIC,
		track_start = 4,
		pattern_start = 0
	},{
		init  = porrasturvat_init,
		frame = porrasturvat,
		bdr   = no_fn,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 0,
		pattern_start = 7
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 0
	},{
		init  = chimera_init,
		frame = chimera,
		bdr   = no_fn,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 5,
		pattern_start = 0
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 0
	},{
		init  = moomin_init,
		frame = moomin,
		bdr   = moomin_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 2,
		pattern_start = 0
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = SFX | MUSIC,
		track_start = 4,
		pattern_start = 0
	},{
		init  = feel_like_computer_init,
		frame = feel_like_computer,
		bdr   = no_fn,
		bank_switch = 3,
		bank_switch_mask = SFX | MUSIC,
		track_start = 0,
		pattern_start = 11
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = SFX | MUSIC,
		track_start = 4,
		pattern_start = 0
	},{
		init  = hesburger_init,
		frame = hesburger,
		bdr   = no_fn,
		bank_switch = 1,
		bank_switch_mask = SFX | MUSIC,
		track_start = 5,
		pattern_start = 0
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = SFX | MUSIC,
		track_start = 4,
		pattern_start = 0
	},{
		init  = hockey_init,
		frame = hockey,
		bdr   = no_fn,
		bank_switch = 1,
		bank_switch_mask = SFX | MUSIC,
		track_start = 6,
		pattern_start = 0
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 0
	},{
		init  = hfc_init,
		frame = hfc,
		bdr   = no_fn,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 1,
		pattern_start = 5
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = SFX | MUSIC,
		track_start = 4,
		pattern_start = 0
	},{
		init  = ddt_init,
		frame = ddt,
		bdr   = ddt_bdr,
		bank_switch = 1,
		bank_switch_mask = SFX | MUSIC,
		track_start = 2,
		pattern_start = 0
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = SFX | MUSIC,
		track_start = 4,
		pattern_start = 0
	},{
		init  = stickman_init,
		frame = stickman,
		bdr   = no_fn,
		bank_switch = 1,
		bank_switch_mask = SFX | MUSIC,
		track_start = 7,
		pattern_start = 0
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = SFX | MUSIC,
		track_start = 4,
		pattern_start = 0
	},{
		init  = inercia_init,
		frame = inercia,
		bdr   = no_fn,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 3,
		pattern_start = 11
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = SFX | MUSIC,
		track_start = 4,
		pattern_start = 0
	},{
		init  = gerbera_init,
		frame = gerbera,
		bdr   = no_fn,
		bank_switch = 2,
		bank_switch_mask = SFX | MUSIC,
		track_start = 2,
		pattern_start = 3
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 0
	},{
		init  = disk_throwing_init,
		frame = disk_throwing,
		bdr   = no_fn,
		bank_switch = 3,
		bank_switch_mask = SPRITES,
		track_start = 1,
		pattern_start = 11
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 0
	},{
		init  = oprah_init,
		frame = oprah,
		bdr   = oprah_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 6,
		pattern_start = 8
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = SFX | MUSIC,
		track_start = 4,
		pattern_start = 0
	},{
		init  = lifeforce_init,
		frame = lifeforce,
		bdr   = no_fn,
		bank_switch = 1,
		bank_switch_mask = SFX | MUSIC,
		track_start = 1,
		pattern_start = 1
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = TILES | SPRITES | PALETTE | SFX | MUSIC,
		track_start = 4,
		pattern_start = 0
	},{
		init  = atomicplayboy_init,
		frame = atomicplayboy,
		bdr   = no_fn,
		bank_switch = 1,
		bank_switch_mask = TILES | SPRITES | PALETTE | SFX | MUSIC,
		track_start = 3,
		pattern_start = 4
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = TILES | SPRITES | PALETTE | SFX | MUSIC,
		track_start = 4,
		pattern_start = 0
	},{
		init  = kewlers_init,
		frame = kewlers,
		bdr   = no_fn,
		bank_switch = 1,
		bank_switch_mask = SFX | MUSIC,
		track_start = 4,
		pattern_start = 2
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = SFX | MUSIC,
		track_start = 4,
		pattern_start = 0
	},{
		init  = prophecy_init,
		frame = prophecy,
		bdr   = no_fn,
		bank_switch = 2,
		bank_switch_mask = SFX | MUSIC,
		track_start = 2,
		pattern_start = 13
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = SFX | MUSIC,
		track_start = 4,
		pattern_start = 0
	},{
		init  = ceasefire_init,
		frame = ceasefire,
		bdr   = no_fn,
		bank_switch = 1,
		bank_switch_mask = SFX | MUSIC,
		track_start = 4,
		pattern_start = 5
	},{
		init  = noise_switch_init,
		frame = noise_switch,
		bdr   = noise_switch_bdr,
		bank_switch = 0,
		bank_switch_mask = SFX | MUSIC,
		track_start = 4,
		pattern_start = 0
	},{
		init  = scientist_init5,
		frame = scientist,
		bdr   = no_fn,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 1,
		pattern_start = 7
	}--[[,{
		init  = whaa_init,
		frame = whaa,
		bdr   = whaa_bdr,
		bank_switch = 0,
		bank_switch_mask = 0,
		track_start = 4,
		pattern_start = 12
	}--]]
}

function start_scene(scene_id)
	current_scene_id = scene_id
	sync(scenes[scene_id].bank_switch_mask, scenes[scene_id].bank_switch)
	music(scenes[scene_id].track_start, scenes[scene_id].pattern_start, -1, false)
	musicplaying = true
	scenes[current_scene_id].init()
	current_bank_id = scenes[scene_id].bank_switch
end

function TIC()

	--hide cursor
	poke(16379,2)
	
	if keyp(60) then -- left arrow, go back one frame
		musicplaying = false
		music()
		
		current_scene_id = current_scene_id - 1
		if current_scene_id < 1 then current_scene_id = 1 end
		start_scene(current_scene_id)
	end
	if keyp(61) then -- right arrow, go forward one frame
		musicplaying = false
		music()
		
		current_scene_id = current_scene_id + 1
		if current_scene_id > #scenes then current_scene_id = current_scene_id - 1 end
		start_scene(current_scene_id)
	end
	
	if not musicplaying then
		if current_scene_id < 1 then current_scene_id = 1 end
		start_scene(current_scene_id)
	end

	-- get global music sync refs
	_t=time()
	_track = peek(0x13FFC)
	_pattern = peek(0x13FFD)
	_row = peek(0x13FFE)

	-- check what track we are at
	-- skip to next track and scene when no longer playing music (loop false) 
	if _track == 255 then
		if current_scene_id < #scenes then
			current_scene_id = current_scene_id + 1
			if current_scene_id <= #scenes then
				musicplaying = false
				music()
				start_scene(current_scene_id)
			end
		else
			trace("Thanks for watching!")
			exit()
		end
	end

	if current_scene_id <= #scenes then scenes[current_scene_id].frame() end
--[[
	print(_track,2,0,5)
	print(_pattern,20,0,5)
	print(_row,40,0,5)
	print("scene: " .. current_scene_id,2,10,5)
	print("bank: " .. current_bank_id,2,20,5)
	print(ftime(),60,0,5)--]]
end

function BDR(l)
	scenes[current_scene_id].bdr(l)
end
