
-- extremely naive polygon drawing function that just draws each consecutive set of three vertices as a triangle
function convex_poly(v, color)
	for i = 2, #v - 1 do
		tri(v[1][1], v[1][2], v[i][1], v[i][2], v[i + 1][1], v[i + 1][2], color)
	end	
end

-- function that draws an animated layer of polygons
-- format of polygon data:
-- {
--	{{x1, y1, x1amp, y1amp}, {x2, y2, x2amp, y2amp}, {x3, y3, x3amp, y3amp}, {x4, y4, x4amp, y4amp}}  <- this is one polygon
-- }	
function chimera_layer(polys, c, t)
	for i, poly in ipairs(polys) do
		verts = animated_verts(poly, t)
		convex_poly(verts, c)
	end
end

-- function that animates a polygon according to the t value and the amplitudes set in the polygon data
function animated_verts(data, t)
	phase = math.sin(t / 30000)
	result = {}
	for i, vert in ipairs(data) do
		new_vert = {vert[1] + vert[3] * phase, vert[2] + vert[4] * phase}
		table.insert(result, new_vert)
	end
	return result
end

chimera_st=0
function chimera_init()
	chimera_st=_t
	poke(0x3FF8,0) -- border
	poke(0x3FF9,0) -- screen offset
	poke(0x3FFA,0)
	vbank(1)
	poke(0x03FF8, 15)
	vbank(0)
	-- generate palette
	for i = 0, 3 do
		addr = 16320 + i * 3
		poke(addr, i * 60)
		poke(addr + 1, 0)
		poke(addr + 2, 0)
	end
	salad(1,{passionfruit},4000,1000)
	salad(3,{pear,kiwi,cherry},1200,2000)
end

function chimera()
	local t=_t-chimera_st

	cls(3)

	local layer_polys = {
		{{97, 19, 0, 10}, {113, 26, -3, -10}, {106, 90, 0, 0}, {91, 87, 0, 0}},
		{{20, 40, -15, 0}, {120, 60, -5, 9}, {110, 100, -15, 30}, {80, 130, 10, -5}},
		{{0, 60, 0, -10}, {80, 50, 0, -10}, {80, 100, 0, 10}, {0, 140, 0, 10}}
	}

	chimera_layer(layer_polys, 2, t)

	layer_polys = {
		{{75, 23, 0, 0}, {107, 26, 9, 0}, {106, 88, 0, 0}, {83, 91, 0, 0}},
		{{104, 61, 0, 0}, {113, 63, 6, 0}, {119, 80, -5, 0}, {101, 84, 0, 0}},
		{{23, 19, 0, 0}, {14, 29, -3, 0}, {80, 126, 5, -2}, {106, 96, 0, 0}},
		{{137, -2, -6, 0}, {121, 117, -7, -3}, {135, 113, 0, 0}, {148, -2, 0, 0}},
		{{0, 65, 0, -10}, {80, 55, 0, -10}, {80, 95, 0, 10}, {0, 135, 0, 10}}
	}

	chimera_layer(layer_polys, 1, t)

	layer_polys = {
		{{10, 10, -5, 7}, {100, 10, 4, 8}, {100, 100, 6, -11}, {80, 120, 9, -5}},
		{{95, 105, -3, 3}, {89, 83, 7, -2}, {141, 70, 7, 2}, {134, 85, -13, 7}},
		{{136, 80, -5, 5}, {148, 56, 16, 3}, {123, 61, 1, -2}, {127, 80, -1, 1}},
		{{136, 69, 5, -2}, {122, 123, -8, -5}, {232, 113, -8, 4}, {234, 59, 2, 2}},
		{{141, 74, -3, 0}, {141, 0, 5, 0}, {269, 0, 6, 0}, {237, 84, -4, 7}},
		{{0, 70, 0, -10}, {80, 60, 0, -10}, {80, 90, 0, 10}, {0, 130, 0, 10}}
	}

	chimera_layer(layer_polys, 0, t)

	overlay_defaults((_t-chimera_st),"02","CHIM")
end