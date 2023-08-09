
testcard_st = 0
function testcard_init()
	testcard_st = _t
	sweetie16_init()
end

function testcard()

	-- check for Mac/Linux timming bug
	-- exits if found
	timeChk()

	local t = _t-testcard_st
	cls()
	
	local w = 13
	for x = 0,24 do
		for y = 0,14 do
			rectb(x * w + 3, y * w - 2, w + 1, w + 1, 12)
		end
	end

	w = 12.9
	for i = 0, 11 do
		rect(43 + i * w, 12, 14, 116, 11 - i)
	end

	w = 38.7
	for i = 0, 3 do
		rect(43 + i * w, 37, 39, 26, 15 - i)
	end

	rect(43, 63, 155, 39, 12)

	rect(60, 64, 121, 16, 0)
	rect(60, 80, 139, 10, 13)

	rect(150, 80, 49, 10, 3)

	function textbox_stripes(x, w, amt)
		subw = w / amt
		rect(x, 80, w, 10, 12)
		for i = 1, amt - 2, 2 do
			rect(x + i * subw, 80, subw, 10, 0)
		end
	end

	textbox_stripes(62, 22, 7)
	textbox_stripes(92, 22, 11)
	textbox_stripes(124, 21, 21)

	--poke4(0x3ff0 * 2 + 15, 12)
	--vhstext(str1, 61, 65)
	--vhstext(str2, 122, 65)
	--poke4(0x3ff0 * 2 + 15, 15)

	circb(120, 63, 88, 12)

	line(120, 37, 120, 101, 12)

	tri(118, 90, 122, 90, 122, 101, 0)
	
	print("ASSEM",61,67,12,true,2,false)
	print("BLYTV",122,67,12,true,2,false)

--print("banana",0,0,12)
	overlay_defaults(t,"00","SGNL")
end
