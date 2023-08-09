
------------------------------------------
--- nooon stars of the world

--nooon_pal = "b13e535d275d1a1c2c29366f3b5dc9333c57566c8641a6f694b0c225717973eff738b764a7f070ffcd75ef7d57f4f4f4"


nooon_st = 0
nooon_tbl = {}

function nooon_init()
	nooon_st=_t
	sweetie16_init()

	-- precalc u/z values for each pixel
	local p64 = 64/math.pi
	for o=0,240*136 do
		local x=o%240-120
		local y=o/240-68
		nooon_tbl[o+1] = {
			math.atan(x,y)*p64,
			799/math.sqrt(x*x+y*y)
		}
	end

	salad(1,{apple,orange},4000,2000)
	salad(2,{pear,orange,fig,kiwi},5000,1000)
	salad(3,{fig,grapes,pineapple,apple,orange},3200,1000)
	salad(4,{cherry,banana,fig,apple},7000,3000)
end

function nooon()
	local t=(_t-nooon_st)*.02
	local P=t//8
	local s=math.cos(t/9)*8
	local ofs=((math.sin(t/7)*15+math.sin(t/5)*6+t)//1-128)*240
	for o=0,240*136 do
		local c=nil
		local ofsy=ofs+o
		if (P>8 and ofsy>=0 and ofsy<=32160*2) then
			-- bitmap colour
			local q=peek4(0x10000+ofsy)
			if q~=8 then
				c=q
			end
		end
		if c==nil then
			-- tunnel colour
			local odd=(o&1)>0
			local u=nooon_tbl[o+1][1]
			local z=nooon_tbl[o+1][2]
			c=((
				(math.abs(odd and u+t or u/2-t)//2)
				&(odd and z-s/2 or z+s)//1.5%4
			)%4)+o%2
		end
		poke4(o,c)
	end
	-- face logo
	if (P>20) and (t%16<8) then
		print("23806",2,112,12,1,2)
		print("faces",2,124,12,1,2)
	end

	overlay_defaults((_t-nooon_st),"95","NOON")
end

