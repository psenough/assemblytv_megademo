
function bowl(pbx,pby,pbw,pbl,pbh,pbbg,pbc)
	--elli(pbx,pby+pbh+1,pbw,pbl,pbbg)
	ellib(pbx,pby+pbh+1,pbw,pbl,0)
	for y=pbh,0,-1 do
		ellib(pbx,pby+y,pbw,pbl,pbc)
	end
	ellib(pbx,pby,pbw,pbl,0)
	line(pbx-pbw,pby+pbh-3,pbx-pbw,pby+pbh+2,0)
	line(pbx+pbw,pby+pbh-3,pbx+pbw,pby+pbh+2,0)
end

function wheel(pbx,pby)
	local pbw = 20
	local pbop = 15
	local pbh = 40
	local pbc = 12
	
	-- white back
	elli(pbx+pbop,pby,pbw,pbh,pbc)
	-- white depth
	pbc=12
	for x=pbx+pbop,pbx,-1 do
		ellib(x,pby,pbw,pbh,pbc)
	end
	-- yellow depth
	pbc=4
	for x=pbx+pbop,pbx,-1 do
		ellib(x,pby-2,pbw*.1,pbh*.1,pbc)
	end
	-- purple depth
	pbc=1
	for x=pbx,pbx-pbop,-1 do
		ellib(x,pby,pbw,pbh,pbc)
	end
	-- outter rim black outline
	pbc=0
	ellib(pbx-pbop,pby,pbw,pbh,pbc)
end

muffi_st=0

function muffi_init()
	muffi_st=_t
	sweetie16_init()
	--[[salad(1,{banana,apple},2000,2000)
	salad(2,{banana},2000,2000)
	salad(3,{banana},2200,2000)
	salad(4,{strawberry},2500,2000)--]]
end

function muffi()

	local t = _t - muffi_st
	cls(4)
	
	-- background banner
	rect(0,0,240,30,8)
	print("Assembly",30,-3,9,false,2)
	print("Summer",40,10,9)
	
	-- mirror
	tri(0,-120, 20,30, 0,260, 14)
	
	for x=2,15,4 do
		line(x,x*2.5-10,x,120-x*6,12)
	end
	
	-- shelter
	-- main body
	clip(20,0,50,60)
	elli(45,50,20,30,12)
	ellib(45,50,20,30,0)
	clip(20,60,50,20)
	elli(45,46,25,20,12)
	ellib(45,46,25,20,0)
	clip()
	-- entrance hole
	circ(43,56,8,15)
	-- roof
	clip(20,0,50,35)
	-- higher part of roof
	elli(45,35,20,16,12)
	ellib(45,35,20,16,0)
	-- top hole
	elli(45,23,4,2,15)
	-- lower part of roof
	clip(20,35,50,30)
	elli(45,35,20,10,12)
	ellib(45,35,20,10,0)
	clip()
	
	
	-- white bowl contents
	local bx=54
	local by=74
	math.randomseed(5)
	for x=-11,6,.25 do
		local bh=8
		tri(bx+x,by+4-bh+math.random(bh)*2,
						bx+x+math.random(bh),by+4-bh+math.random(bh)*2,
						bx+x+math.random(bh),by+4-bh+math.random(bh)*2,
						math.random(5)*3-1)
	end
	-- white bowl
	bowl(bx,by, 14,10, 6, 13,12)
	
	-- pink bowl contents
	bx=60
	by=110
	math.randomseed(5)
	for x=-30,20 do
		local bh=18
		tri(bx+x,by-bh+math.random(bh)*2,
						bx+x+math.random(bh),by-bh+math.random(bh)*2,
						bx+x+math.random(bh),by-bh+math.random(bh)*2,
						math.random()*2//1*8+4)
	end
	-- pink bowl
	bowl(bx,by, 38,22, 8, 4, 10)
	
	poke(0x3FC0+10*3,221)
	poke(0x3FC0+10*3+1,110)
	poke(0x3FC0+10*3+2,186)
	
	-- wheel
	wheel(140,60)
	
	-- dark wood
	tri(120,70, 240,42, 240,192, 7)

	poke(0x3FC0+7*3,114)
	poke(0x3FC0+7*3+1,52)
	poke(0x3FC0+7*3+2,11)
	
	-- light wood
	tri(120,70, 120,76, 240,192, 4)
	tri(240,198, 120,76, 240,192, 4)

	
	-- top logo
	
	
	
	-- live signal
	--if time()%1200//600 == 0 then
		local px=160
		local py=6
		for x=px,px+14 do
			elli(x,py,1,3,2)
		end
		-- L
		line(px+1,py-2,px+1,py+2,12)
		pix(px+2,py+2,12)
		pix(px+3,py+2,12)
		-- I
		line(px+5,py-2,px+5,py+2,12)
		-- V
		line(px+7,py-2,px+7,py+1,12)
		line(px+9,py-2,px+9,py+1,12)
		pix(px+8,py+2,12)
		-- E
		line(px+11,py-2,px+11,py+2,12)
		line(px+11,py-2,px+13,py-2,12)
		line(px+11,py,px+12,py,12)
		line(px+11,py+2,px+13,py+2,12)
	--end
 
	-- bottom banner
	rect(0,110,240,26,0)
	
	local tt = t//100
	local wt = t//10-1200
	if wt < 0 then wt = 0 end
	print(string.sub("ASSEMBLY 03-06.08.2023 HELSINGIN MESSUKESKUS",wt,tt),2+wt*5,114,12,true,1,true)
	
	tt = t//100-47
	if tt < 0 then tt = 0 end
	wt = t//10-1240
	if wt < 0 then wt = 0 end
	print(string.sub("TICKETS ARE SELLING FAST, ACT NOW!",wt,tt),26+wt*5,122,4,true,1,true)
	
	tt = t//100-80
	if tt < 0 then tt = 0 end
	wt = t//10-1280
	if wt < 0 then wt = 0 end
	print(string.sub("SEE THE FULL PROGRAM AT ",wt,tt),22+wt*5,130,12,true,1,true)
	
	tt = t//100-104
	if tt < 0 then tt = 0 end
	wt = t//10-1290
	if wt < 0 then wt = 0 end
	print(string.sub("ASSEMBLY.ORG",wt,tt),118+wt*5,130,2,true,1,true)
	
	-- side chat
	rect(180,0,60,136,15)
	print("stream chat",190,5,12,false,1,true)
	
	print("KurowoTV",182,16,1,false,1,true)
	print(": tho",214,16,12,false,1,true)
	print("paras kaveri sai",182,23,12,false,1,true)
	print("kunno loottia",182,30,12,false,1,true)
	print("sen sub 15 boxin",182,37,12,false,1,true)
	print("kohal (insert",182,44,12,false,1,true)
	print("lennyface)",182,51,12,false,1,true)
	
	print("rriiia",182,58,3,false,1,true)
	print(": harmiku",200,58,12,false,1,true)
	print("tuli voitettuu",182,65,12,false,1,true)
	print("ence paita mut",182,72,12,false,1,true)
	print("ei oo ees omaa",182,79,12,false,1,true)
	print("kokoa :c",182,86,12,false,1,true)
	
	print("TheHerbalisti",182,93,6,false,1,true)
	print(":",230,93,12,false,1,true)
	print("liikkuispa",182,100,12,false,1,true)
	print("kamera",182,107,12,false,1,true)
	
	print("Raitsu",182,114,9,false,1,true)
	print(": miks",204,114,12,false,1,true)
	print("kavijalippu",182,121,12,false,1,true)
	print("mkasaa 30eur",182,128,12,false,1,true)
	
	overlay_defaults((_t-muffi_st),"23","MUFF")
	
end
