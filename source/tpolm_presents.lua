
-------------------------------------
-- tpolm presents

local sc = 0

function tpolm_presents_init0()
	sc=0
end

function tpolm_presents_init1()
	sc=1
end

function tpolm_presents_init2()
	sc=2
end

local presents_st=0
function tpolm_presents_init3()
	sc=3
	presents_st=_t
end

function tpolm_presents()
	local px = 120
	local py = 66
	local ww = 90
	local hh = 50
	
	cls(1)
	
	elli(px,py,ww,hh,0)
	elli(px,py,ww-2,hh-2,4)
	elli(px,py,ww-4,hh-4,0)
	elli(px,py,ww-6,hh-6,12)

	--print("TPOLM",px-76+1,py-14+1,0,true,5,false)
	--print("TPOLM",px-76,py-14,6,true,5,false)
	
	if sc==1 then
		print("and just one or twelve other people",px-68,py+15,0,true,1,true)
--	print("presents",px-30+1,py+20+1,0,true,2,true)
		print("present",px-26,py+24,0,true,2,true)
	elseif sc == 2 then
		print("an Assembly 2023",px-62,py-29,0,true,2,true)
		print("TIC-80 Megademo",px-58,py+16,0,true,2,true)
		print("called",px-22,py+30,0,true,2,true)
	elseif sc == 3 then
		--print("The AssemblyTV",px-56+1,py-30+1,0,true,2,true)
		--print("The AssemblyTV",px-56,py-30,6,true,2,true)
		--print("Megademo!",px-46+1,py+16+1,0,true,3,true)
		--print("Megademo!",px-46,py+16,6,true,3,true)
		print("ASSEMBLY",px-70+1,py-20+1,0,false,3,false)
		print("ASSEMBLY",px-70,py-20,6,false,3,false)
		print("MEGADEMO",px-70+1,py+4+1,0,false,3,false)
		print("MEGADEMO",px-70,py+4,6,false,3,false)
	end

	for x=0,240 do
		for y=0,192 do
			local cc=pix(x,y)
			if cc == 1 then
				pix(x,y,0+((x~y-_t//30))%3)
			end
			if cc == 4 then
				pix(x,y,3+((x-_t//300)|y)%2)
			end
			if cc == 6 then
				pix(x,y,6+((x~y-_t//30))%3)
			end
			if cc == 12 then
				pix(x,y,4+((x~y+_t//30))%3)
			end
		end
	end
	
	overlay_defaults((_t-presents_st),"01","TPOL")
end
