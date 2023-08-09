function drawplayboy()
	-- Mirror the circles?
	circ(10, 10, 6, 14)
	circ(24, 8, 3, 14)
	circ(11, 24, 3, 14)
	circ(220, 10, 6, 14)
	circ(206, 8, 3, 14)
	circ(219, 24, 3, 14)
	circ(10, 126, 6, 14)
	circ(24, 128, 3, 14)
	circ(11, 112, 3, 14)
	circ(220, 126, 6, 14)
	circ(206, 128, 3, 14)
	circ(219, 112, 3, 14)
	-- Actual display stuff, I think you
	-- could pack the head tighter and use
	-- more spr() functions to show it.
	spr(71 + 256, 64, 0, 0, 1, 0, 0, 7, 8)
	spr(71 + 256, 119, 0, 0, 1, 1, 0, 7, 8)
	spr(64 + 256, 64, 64, 0, 1, 0, 0, 7, 8)
	spr(64 + 256, 119, 64, 0, 1, 1, 0, 7, 8)
end

atomic_st = 0
atomic_frm = 0
function atomicplayboy_init()
	atomic_st = _t
	poke(0x3FF8, 0) -- border
	poke(0x3FF9, 0) -- screen offset
	poke(0x3FFA, 0)
	--sync(1 | 2 | 32, 1)

	cls(0)
	drawplayboy()
	pbtex = {}
	for y = 0, 135 do
		pbtex[y] = {}
		for x = 0, 239 do
			pbtex[y][x] = pix(x, y)
		end
	end

	-- create blue-ified palette
	for i = 0, 7 do
		r = peek(16320 + i * 3)
		g = peek(16321 + i * 3)
		b = peek(16322 + i * 3)
		poke(16344 + i * 3, r)
		poke(16345 + i * 3, g)
		poke(16346 + i * 3, (b / 256) ^ 0.6 * 256)
	end

	addr = 0
	atomic_frm = 0

	salad(1,{fig,orange,kiwi},2000,2000)
	salad(2,{orange,fig,kiwi,avocado},2000,2000)
	salad(3,{grapes,apple,orange,banana},2200,1000)
	salad(4,{cherry,pineapple},2000,1000)
end

function pblens(t)
	local cr = 50
	local cx = cr + math.abs(((t+10) / 15) % (480 - cr * 4) - (240 - cr * 2))
	local cy = 0
	if t<3100 then
	 cy = (135 - cr) - 100 * math.abs(math.sin((t+200) / 350))
	else
	 cy = 85 + (t-3100)/3
	end

	for x = 0, 239 do
		local dx = x - cx
		local dx2 = dx * dx
		for y = 0, 135 do
			local dy = y - cy
			local r = math.sqrt(dx2 + dy * dy)
			if r < cr then
				local a = math.atan(dx, dy)
				local r1 = (r / cr) ^ 1.5 * cr
				local tx = (cx + r1 * math.sin(a)) // 1
				local ty = (cy + r1 * math.cos(a)) // 1
				if tx >= 0 and tx <= 239 and ty >= 0 and ty <= 135 then
					pix(x, y, pbtex[ty][tx] + 8)
				else
					pix(x, y, 8)
				end
			else
				pix(x, y, pbtex[y][x])
			end
		end
	end
end

function pbrotozoomer(t)
	local a = t / 1000
	local s = 1 + 0.8 * math.sin(t / 2300)
	local cx = 120 + 120 * math.sin(t / 1234)
	local cy = 68 + 120 * math.sin(t / 2345)
	local C = math.cos(a) * s
	local S = math.sin(a) * s
	for y = 0, 135 do
		local dy = y - cy
		for x = 0, 239 do
			local dx = x - cx
			local tx = (cx + C * dx + S * dy) // 1
			local ty = (cy + C * dy - S * dx) // 1
			pix(x, y, pbtex[ty % 136][tx % 240])
		end
	end
end

function atomicplayboy()
	if atomic_frm < 220 then
		pblens(atomic_frm * 1000 / 60)
		if _row > 16 and addr < 1789 then
			poke(0xff9c, 0x3c)
			poke(0xff9d, 0xf0)
			memcpy(0xff9e, addr + 0x6000, 16)
			addr = addr + 16
		end
	else
		pbrotozoomer((atomic_frm - 220) * 1000 / 60)
	end
	atomic_frm = atomic_frm + 1

	overlay_defaults((_t - atomic_st), "93", "2NDR")
end
