
function qrwx(x,y,wt,ht,wb,hb,o)
	local guy_color = ({4,5,11})[math.random(1,3)]
	local guy_outline = 0
	local eye_color = 12
	
	local m1=math.random() -- left eye h
	local m2=math.random()*2 -- left hand ypos
	local m3=math.random()*2 -- right hand ypos
	local m4=math.random()*1.4 -- hand size
	local m5=math.random()*.06 -- eye sep
	local m6=math.random() -- bellybut
	
	local mouth_move_x = math.sin(o*10//40)*2
	local mouth_move_bx = math.cos(o*6//40)*2-2
	local mouth_move_y = math.cos(o*8//60)*2-2

	-- left ear
	circ(x-wt*.5+mouth_move_x,y-o-ht*.7,wt*.3,guy_color)
	circb(x-wt*.5+mouth_move_x,y-o-ht*.7,wt*.3,guy_outline)
	circb(x-wt*.5+mouth_move_x,y-o-ht*.7,wt*.15,guy_outline)
	
	-- right ear
	circ(x+wt*.6+mouth_move_x,y-o-ht*.7,wt*.3,guy_color)
	circb(x+wt*.6+mouth_move_x,y-o-ht*.7,wt*.3,guy_outline)
	
	-- top / head
	clip(x-wt+mouth_move_x,y-ht*2-o+1,wt*2+2,ht*2+1)
	elli(x+mouth_move_x,y-o,wt,ht,guy_color)
	ellib(x+mouth_move_x,y-o,wt,ht,guy_outline)
	clip()
	line(x-wt+1+mouth_move_x,y-o+1,x+wt+mouth_move_x,y-o+1,guy_outline)
	
	-- rest of right ear
	circ(x+wt*.6+mouth_move_x,y-o-ht*.7,wt*.3-1,guy_color)
	circb(x+wt*.6+mouth_move_x,y-o-ht*.7,1,guy_outline)
	
	-- eyes
	-- left
	elli(x-wt*(.2+m5)+mouth_move_x,y-o-ht*.3,wt*.2,ht*(.1+m1*.1),eye_color)
	ellib(x-wt*(.2+m5)+mouth_move_x,y-o-ht*.3,wt*.2,ht*(.1+m1*.1),guy_outline)
	circ(x-wt*(.2+m5)+mouth_move_x,y-o-ht*.3,0,guy_outline)
	--line(x-wt*.3,y-o-ht*(.55+m1*.1),x-wt*.15,y-o-ht*(.5+m1*.1),guy_outline)
	line(x-wt*(.2+m5)+mouth_move_x,y-o-ht*(.4+m1*.1),
						x-wt*(.35+m5)+mouth_move_x,y-o-ht*(.5+m1*.1),guy_outline)
	clip(x-wt*(.2+m5)-wt*.12+mouth_move_x,y-o-ht*(.5+m1*.1)-wt*.12,
						wt*.28,wt*.12)
	circb(x-wt*(.2+m5)+mouth_move_x,y-o-ht*(.5+m1*.1),
						wt*.12,guy_outline)
	clip()
	-- right
	elli(x+wt*(.2+m5)+mouth_move_x,y-o-ht*.35,wt*.2,ht*.2,eye_color)
	ellib(x+wt*(.2+m5)+mouth_move_x,y-o-ht*.35,wt*.2,ht*.2,guy_outline)
	circ(x+wt*(.17+m5)+mouth_move_x,y-o-ht*.34,0,guy_outline)
	--line(x+wt*.3,y-o-ht*.65,x+wt*.1,y-o-ht*.65,guy_outline)
	line(x+wt*(.2+m5)+mouth_move_x,y-o-ht*.55,
						x+wt*(.2+m5)+mouth_move_x,y-o-ht*.6,guy_outline)
	--clip(x+wt*(.2+m5)-wt*.12,y-o-ht*.6-wt*.12,
	--					wt*.28,wt*.22)
	circb(x+wt*(.15+m5)+mouth_move_x,y-o-ht*.6,
						wt*.1,guy_outline)
	clip()
	
	-- bottom / body
	clip(x-wb+mouth_move_bx,y-mouth_move_y,wb*2+2,hb*2)
	elli(x+mouth_move_bx,y-mouth_move_y,wb,hb,guy_color)
	ellib(x+mouth_move_bx,y-mouth_move_y,wb,hb,guy_outline)
	clip()
	line(x-wb+1+mouth_move_bx,y-mouth_move_y, x+wb+mouth_move_bx,y-mouth_move_y,guy_outline)
	
	-- hands
	-- left
	local whx=wt*.12+m4 -- radius of hand
	local lhx=x-wt*1.3+mouth_move_bx -- center pos
	local lhy=y+ht*(.18*m2)+mouth_move_y
	circ(lhx,lhy,whx,guy_color)
	circb(lhx,lhy,whx,guy_outline)
	-- right
	local rhx=x+wt*1.3+1+mouth_move_x*.5 -- center pos
	local rhy=y+ht*(.18*m3)-mouth_move_y*.5
	circ(rhx,rhy,whx,guy_color)
	circb(rhx,rhy,whx,guy_outline)

	-- feet
	clip(x-wb-3,y+hb*.8,wb*2,hb*.24+1)
	--left
	elli(x-wb*.3-3,y+hb,wb*.2,hb*.15,guy_color)
	ellib(x-wb*.3-3,y+hb,wb*.2,hb*.15,guy_outline)
	--right
	elli(x+wb*.5-3,y+hb,wb*.2,hb*.15,guy_color)
	ellib(x+wb*.5-3,y+hb,wb*.2,hb*.15,guy_outline)
	--line of soles on clipline
	clip()
	line(x-wb*.466-3,y+hb*1.04, x-wb*.13-3 ,y+hb*1.04, guy_outline)	
	line(x+wb*.33-3,y+hb*1.04, x+wb*.66-3,y+hb*1.04, guy_outline)	
end

function television(x,y,w,ch)
	-- box
	rect( x+1,y+1,w*1.2-2,w*.7-2,4) 
	rectb(x+1,y-1,w*1.2-1,w*.7+2,0)
	rectb(x  ,y  ,w*1.2+1,w*.7,  0)
	
	-- buttons
	for i=0,2 do
		for j=0,3 do
			rect(x+w*.96+i*w*.07,y+w*.1+j*w*.07,w*.05,w*.05,0)
			-- selected channel
			if i+j*3 == ch then
				rect(x+w*.96+i*w*.07,y+w*.1+j*w*.07,w*.05,w*.05,2)
			end
		end
	end
	
	-- screen
	rect( x+1+w*.1,y+1+w*.1,w*.8-2,w*.5-2,3)
	rectb(x+1+w*.1,y-1+w*.1,w*.8-1,w*.5+2,0)
	rectb(x  +w*.1,y  +w*.1,w*.8+1,w*.5,  0)

	-- legs
	-- left
	rect(x+w*.1,y+w*.7,w*.08,w*.1,4)
	rectb(x+w*.1,y+w*.7,w*.08,w*.1,0)
	-- right
	rect(x+w*1.05,y+w*.7,w*.08,w*.1,4)
	rectb(x+w*1.05,y+w*.7,w*.08,w*.1,0)
	
	-- antena
	line(x+w*.4,y-w*.2,x+w*.6,y,0)
	line(x+w*.8,y-w*.2,x+w*.6,y,0)
end


function sofa(x,y,w)
	-- back side of sofa
	rect(x-1,y, w,80, 4)
	rectb(x-1,y, w,80, 0)
	rectb(x-2,y+1, w+2,80-2, 0)
	
	-- seats of sofa
	rect(x-1,y+62, w,18, 4)
	rectb(x-1,y+62, w,18, 0)
	rectb(x-2,y+63, w+2,18-2, 0)		
	rect(x-1,y+45, w*.3,18, 3)
	rectb(x-1,y+45, w*.3,18, 0)
	rectb(x-2,y+46, w*.3+2,18-2, 0)
	rect(x+50,y+45, w*.3+1,18, 3)
	rectb(x+50,y+45, w*.3+1,18, 0)
	rectb(x+50-1,y+45+1, w*.3+3,18-2, 0)
	rect(x+102,y+45, w*.3,18, 3)
	rectb(x+102,y+45, w*.3,18, 0)
	rectb(x+102-1,y+45+1, w*.3+2,18-2, 0)
	
	-- left side of sofa
	rect(x-18,y+30, w/8,50, 4)
	rectb(x-18,y+30, w/8,50, 0)
	rectb(x-18-1,y+30+1, w/8+2,50-2, 0)
	
	-- right side of sofa
	rect(x+152,y+30, w/8,50, 4)
	rectb(x+152,y+30, w/8,50, 0)
	rectb(x+152-1,y+30+1, w/8+2,50-2, 0)
end

function school_of_qrwx(x,y,fx,fy,srow,erow,fdelay,fruits)

	local mouths={}
	mouths[1]=3
	mouths[2]=3
	mouths[3]=3

	local hei={}
	hei[1]=0
	hei[2]=0
	hei[3]=0
	math.randomseed(3)
	for i=0,2 do
		local widt=10+math.random()*10
		local heit=widt*(math.random()*0.6+1.0)
		local mm=math.random()
		for j=0,6 do void=math.random() end
		hei[i+1]=widt*mm+heit*(1-mm)
	end
	
	math.randomseed(3)
	if _row > srow and _row < erow then
		for i=0,2 do
			local fruit =(fruits)[math.random(1,#fruits)]
			local delay = math.random(fdelay)
			
			if _row > srow+delay then
				fruit_emoji(fx+i*52,fy+40-hei[i+1]*2,fruit)
				if _row < srow+delay+3 then
					QRWX_speak()
					mouths[i+1] = 5
				end
			end
		end
	end
	
	math.randomseed(3)
	for i=0,2 do
		local widt=10+math.random()*10
		local heit=widt*(math.random()*0.6+1.0)
		local widb=widt
		local mm=math.random()
		local heib=widt*mm+heit*(1-mm)
		qrwx(x+i*52,y-heib//1,widt,heit,widb,heib,mouths[i+1])
	end
end

function QRWX_scientist(t,lx,ly,lw,lh)
	clip(lx,ly,lw,lh)
	for x=lx,lx+lw-1,8 do
		for y=ly,ly+lh-1,8 do
			local c = ((x//8)~(y//8))%2
			if c == 0 then
				c = 13
			else
				c = 2
			end
			rect(x,y,8,8,c)
		end
	end	
	-- bg
	rect(lx,ly+lh*.8,lx+lw,ly+lh,3)
	--body
	elli(lx+lw*.7,ly+lh*1.6,14,34,12)
	-- tri head
	tri(lx+lw*.5,ly+lh*.6, lx+lw*.75,ly+lh*.1, lx+lw*.9,ly+lh*.7,4)
	-- eyes
	circ(lx+lw*.64,ly+lh*.45,2,12)
	pix(lx+lw*.64,ly+lh*.45,0)
	circ(lx+lw*.78,ly+lh*.45,2,12)
	pix(lx+lw*.78,ly+lh*.45,0)
	-- mouth
	elli(lx+lw*.7,ly+lh*.6,2,1,0)
	-- tic80
	rect(lx+lw*.1,ly+lh*.6, lw*.3,lh*.35, 9)
	rectb(lx+lw*.1,ly+lh*.6, lw*.3,lh*.35, 0)
	clip()
	print("69",lx+1,ly+1,6,true,1,true)
end

function QRWX_tpolm(t,lx,ly,lw,lh)
	rect(lx,ly,lw,lh,1)
	elli(lx+lw*.5,ly+lh*.5,17,9,12)
	print("TPOLM",lx+12,ly+14,6,false,1,false)
	for x=lx,lx+lw-1 do
		for y=ly,ly+lh-1 do
			local cc=pix(x,y)
			if cc == 1 then
				pix(x,y,0+((x~y-t//30))%3)
			end
			if cc == 4 then
				pix(x,y,3+((x-t//300)|y)%2)
			end
			if cc == 6 then
				pix(x,y,6+((x~y-t//30))%3)
			end
			if cc == 12 then
				pix(x,y,4+((x~y+t//30))%3)
			end
		end
	end
	print("71",lx+1,ly+1,6,true,1,true)
end

function QRWX_noise(t,lx,ly,lw,lh)
	math.randomseed(t)
	for x=lx,lx+lw-1 do
		for y=ly,ly+lh-1 do
			pix(x,y,math.random()*4+12)
		end
	end
end

function QRWX_tunnel(t,lx,ly,lw,lh)
	for x=lx,lx+lw-1 do
		for y=ly,ly+lh-1 do
			local tx=x-lx-lw*.5
			local ty=y-ly-lh*.5
			local n=math.atan2(ty,tx)*3
			local rs=(1.5+math.sin(3*n+t/200))/(tx*tx+ty*ty)^.4*(3+math.sin(t/500)*2)
			poke4((x+y*240),math.sin(n*1+math.sin(rs*2+t/300)*3+t/250)^.3/rs)
		end
	end
	print("72",lx+1,ly+1,6,true,1,true)
end

function QRWX_plasma(t,lx,ly,lw,lh)
	for x=lx,lx+lw-1 do
		for y=ly,ly+lh-1 do
			z=math.sin((x-lw*.5)/9-t/400)*2+math.cos((x-lw*.5)/30-t/200)*4+math.sin((y-lh*.5)/8+t/500)
			pix(x,y,z)
		end
	end
	print("73",lx+1,ly+1,6,true,1,true)
end

function QRWX_speak()
	sfx(16,"G-0",3,1)
end

function QRWX_floor(y)
	rect(0,y,240,100,0)
	rect(0,y+2,240,100,1)
end

qrwx_st = 0
function qrwx_init()
	qrwx_st = _t
	sweetie16_init()
end

QRWX_TV_SWITCH = 4
QRWX_NOISE_SWITCH_LEN = 2
QRWX_DR_SPEAK = 12
QRWX_DR_MOUTH_TIME = 2
QRWX_DR_FRUIT_TIME = 8
QRWX_COUCH_SWITCH = 26
QRWX_SCHOOL_REPLY = 30

function qrwx_1()
	poke(0x3FF8,6)
	clip()
	cls(6)
	local t=(_t-qrwx_st)
	
	if _row < QRWX_COUCH_SWITCH then
		math.randomseed(13)

		local mouth = 3
		if (_row > QRWX_DR_SPEAK and _row < QRWX_DR_SPEAK + QRWX_DR_MOUTH_TIME) then
			mouth = 5
			QRWX_speak()
		end
		qrwx(176,67,28,31,28,31,mouth)
		
		-- screen
		local lx=39
		local lw=53
		local ly=54
		local lh=33
		if _row > QRWX_TV_SWITCH  then
			television(30,46,70,3)
			if _row > QRWX_TV_SWITCH + QRWX_NOISE_SWITCH_LEN then
				QRWX_tpolm(_t,lx,ly,lw,lh)
			else
				QRWX_noise(_t,lx,ly,lw,lh)
			end
		else
			television(30,46,70,2)
			--QRWX_noise(_t,lx,ly,lw,lh)
			QRWX_scientist(_t,lx,ly,lw,lh)
		end
		
		if _row > QRWX_DR_SPEAK and _row < QRWX_DR_SPEAK+QRWX_DR_FRUIT_TIME then
			fruit_emoji(128,16,fig)
		end
		
		QRWX_floor(100)
	else
		QRWX_floor(100)
	
		sofa(48,30,154)

		local x=69
		local y=81
		local fx=42
		local fy=10
		local srow=QRWX_SCHOOL_REPLY
		local erow=srow+QRWX_DR_FRUIT_TIME
		local fdelay=4
		local fruits={fig,banana,kiwi,pineapple}
		school_of_qrwx(x,y,fx,fy,srow,erow,fdelay,fruits)
	end
	
	overlay_defaults((_t-qrwx_st),"","")
end

function qrwx_2()
	poke(0x3FF8,6)
	clip()
	cls(6)
	local t=(_t-qrwx_st)
	
	if _row < QRWX_COUCH_SWITCH then
			
		math.randomseed(13)

		local mouth = 3
		if (_row > QRWX_DR_SPEAK and _row < QRWX_DR_SPEAK+QRWX_DR_MOUTH_TIME) then
			mouth = 5
			QRWX_speak()
		end
		qrwx(176,67,28,31,28,31,mouth)
		
		-- screen
		local lx=39
		local lw=53
		local ly=54
		local lh=33
		if _row > QRWX_TV_SWITCH then
			television(30,46,70,4)
			if _row > QRWX_TV_SWITCH + QRWX_NOISE_SWITCH_LEN then
				QRWX_tunnel(_t,lx,ly,lw,lh)
			else
				QRWX_noise(_t,lx,ly,lw,lh)
			end
		else
			television(30,46,70,3)
			QRWX_tpolm(_t,lx,ly,lw,lh)
		end
		
		if _row > QRWX_DR_SPEAK and _row < QRWX_DR_SPEAK+QRWX_DR_FRUIT_TIME then
			fruit_emoji(128,16,starfruit)
		end
		
		QRWX_floor(100)
	else
		QRWX_floor(100)
	
		sofa(48,30,154)

		local x=69
		local y=81
		local fx=42
		local fy=10
		local srow=QRWX_SCHOOL_REPLY
		local erow=srow+QRWX_DR_FRUIT_TIME
		local fdelay=4
		local fruits={banana,mango,strawberry}	
		school_of_qrwx(x,y,fx,fy,srow,erow,fdelay,fruits)
	end
	
	overlay_defaults((_t-qrwx_st),"","")
end


function qrwx_3()
	poke(0x3FF8,6)
	clip()
	cls(6)
	local t=(_t-qrwx_st)
	
	if _row < QRWX_COUCH_SWITCH then

		math.randomseed(13)

		local mouth = 3
		if (_row > QRWX_DR_SPEAK and _row < QRWX_DR_SPEAK+QRWX_DR_MOUTH_TIME) then
			mouth = 5
			QRWX_speak()
		end
		qrwx(176,67,28,31,28,31,mouth)
		
		-- screen
		local lx=39
		local lw=53
		local ly=54
		local lh=33
		if _row > QRWX_TV_SWITCH then
			television(30,46,70,5)
			if _row > QRWX_TV_SWITCH + QRWX_NOISE_SWITCH_LEN then
				QRWX_plasma(_t,lx,ly,lw,lh)
			else
				QRWX_noise(_t,lx,ly,lw,lh)
			end
		else
			television(30,46,70,4)
			QRWX_tunnel(_t,lx,ly,lw,lh)
		end
		
		if _row > QRWX_DR_SPEAK and _row < QRWX_DR_SPEAK+QRWX_DR_FRUIT_TIME then
			fruit_emoji(128,16,apple)
		end
		
		QRWX_floor(100)
	else
		QRWX_floor(100)
	
		sofa(48,30,154)

		local x=69
		local y=81
		local fx=42
		local fy=10
		local srow=QRWX_SCHOOL_REPLY
		local erow=srow+QRWX_DR_FRUIT_TIME
		local fdelay=4
		local fruits={apple,kiwi,blueberry}	
		school_of_qrwx(x,y,fx,fy,srow,erow,fdelay,fruits)
	end
	
	overlay_defaults((_t-qrwx_st),"","")
end

function qrwx_bdr(l)
	if l > 103 then 
		if l < 106 then
			poke(0x3FF8,0)
		else
			poke(0x3FF8,1)
 	end
 end
end
