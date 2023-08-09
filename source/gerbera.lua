local GERB_SPK_W=110
local GERB_SKP_H=65

gerbera_st = 0
function gerbera_init()
	sweetie16_init()
	gerbera_st = _t
	salad(1,{peach,fig,papaya},2000,2000)
	salad(2,{fig,kiwi,pineapple},2000,1000)
	salad(3,{grapes,orange},2200,1000)
	salad(4,{cherry,blueberry,papaya},2000,3000)
end

function gerbera()
	cls()
	local t=(_t-gerbera_st)//30

	-- graf
	for i=0,250 do
		circ(
			120
				+math.sin(i/7)*20
				+math.sin(i/30)*40,
			50
				+math.cos(i/10)*30
				+math.cos(i/20)*30,
			3,
			1
		)
	end

	local lHandX=((math.sin(t/30)*2)^4)/4
	local rHandX=((math.sin(t/15)*2)^4)/4+38
	local rHandY=((math.sin(t/15)*2)^4)/6+95

	-- left arm
	for i=0,16 do
		circb(
			120+math.cos(1.5+i/5)*17*(1-lHandX/10),
			98+-math.sin(1.5+i/5)*5,
			3,15)
	end

	for i=0,10 do
		local x=120-math.cos(1.5+i/3)*10*(1-(rHandX-38)/10)+38
		local y=95+-math.sin(1.5+i/3)*2
		circ(x,y,3,0)
		circb(x,y,3,15)
	end

	-- body
	rect(120,89,35,30,7)
	-- meter
	rect(120+20,89+3,12,10,12)
	rectb(120+20,89+3,12,10,0)
	line(120+22,89+5,120+20+5,89+3+5,0)
	-- switch
	rect(120+5,89+5,3,4,12)
	rectb(120+5,89+5,3,4,0)

	-- head
	local pal={0,7,11,12}
	for x=0,35+4 do
		for y=0,16 do
			local c=math.sin(y/16*3.14)*3
				+(x*2-y%2)%4/4
				pix(120-2+x,65+y,pal[c//1+1])
		end
	end

	local p=math.sin(t/10)+math.sin(t/30)
	local q=math.abs(p)

	--aerial
	rect(120+5,65-11+q*2,3,12-q*2,12)
	rect(120+6,65-25+q*3,1,15,12)
	rect(120+5,65-29+q*3,3,3,12)

	-- supports
	rect(120+4,65+17,2,6,12)
	rect(120+29,65+17,2,6,12)

	-- light L
	rect(120-9,65+5,4,5,12)
	rect(120-4,65+4,1,7,12)

	-- light R
	rect(120+5+35,65+5,4,5,12)
	rect(120+3+35,65+4,1,7,12)

	-- "face"
	rect(120+1,65+3+p,35-2,11,12)
	rectb(120+1,65+3+p*1,35-2,11,15)
	rect(120+4,65+4+p*1,35-8,9,14)
	rect(120+4,65+4+p*3,35-8,9,13)
	rectb(120+4,65+4+p*3,35-8,9,0)

	-- eyes
	circ(120+9,65+8+p*3,3,0)
	circ(120+9,65+8+p*3,2,2)
	circ(120+9,65+8+p*3,1,3)

	circ(120+17,65+8+p*3,3,0)
	circ(120+17,65+8+p*3,2,2)
	circ(120+17,65+8+p*3,1,3)

	circ(120+25,65+8+p*3,3,0)
	circ(120+25,65+8+p*3,2,2)
	circ(120+25,65+8+p*3,1,3)


	gerb_speaker(0,135-GERB_SPK_W-10,t)
	tri(
		GERB_SKP_H,135-GERB_SPK_W-10,
		GERB_SKP_H+5,135-GERB_SPK_W+5,
		GERB_SKP_H+5,115,
		0
	)
	tri(
		GERB_SKP_H,135-GERB_SPK_W-10,
		GERB_SKP_H,115,
		GERB_SKP_H+5,115,
		0
	)
	line(
		GERB_SKP_H,135-GERB_SPK_W-10,
		GERB_SKP_H+5,135-GERB_SPK_W+5,
		15
	)
	line(
		GERB_SKP_H+5,135-GERB_SPK_W+5,
		GERB_SKP_H+5,115,
		15
	)

	gerb_speaker(240-GERB_SKP_H,135-GERB_SPK_W-10,t)
	tri(
		240-GERB_SKP_H,135-GERB_SPK_W-10,
		240-GERB_SKP_H-5,135-GERB_SPK_W+5,
		240-GERB_SKP_H-5,115,
		0)
	tri(
		240-GERB_SKP_H,135-GERB_SPK_W-10,
		240-GERB_SKP_H,115,
		240-GERB_SKP_H-5,115,
		0)
	line(
		240-GERB_SKP_H,135-GERB_SPK_W-10,
		240-GERB_SKP_H-5,135-GERB_SPK_W+5,
		15
	)
	line(
		240-GERB_SKP_H-5,135-GERB_SPK_W+5,
		240-GERB_SKP_H-5,115,
		15
	)

	-- desk front
	rect(GERB_SKP_H+5,120,100,8,4)
	for y=121,128,2 do
		line(GERB_SKP_H+5,y,GERB_SKP_H+104,y,3)
	end

	-- desk top
	tri(
		GERB_SKP_H+15,110,
		GERB_SKP_H+5,130-10,
		GERB_SKP_H+105,130-10,
		3)
	tri(
		GERB_SKP_H+100-5,110,
		GERB_SKP_H+15,110,
		GERB_SKP_H+105,130-10,
		3)
	for y=110,120,2 do
		line(GERB_SKP_H+5,y,GERB_SKP_H+105,y,0)
	end

	-- deck L
	rect(GERB_SKP_H+9,109,38,7,12)
	-- top
	tri(
		GERB_SKP_H+9+7,109-10,
		GERB_SKP_H+9,109,
		GERB_SKP_H+9+38,109,
		15)
	tri(
		GERB_SKP_H+9+7,109-10,
		GERB_SKP_H+9+38,109-10,
		GERB_SKP_H+9+38,109,
		15)
	-- feet
	rect(GERB_SKP_H+9+2,109+7,7,2,14)
	rect(GERB_SKP_H+9+4,109+7,3,2,13)
	rect(GERB_SKP_H+9+2+28,109+7,7,2,14)
	rect(GERB_SKP_H+9+4+28,109+7,3,2,13)
	-- platter
	elli(95,103,15,3,12)
	elli(95,103-2,15,3,0)
	line(95,103-3,95,103-4,13)
	-- tone arm
	line(85,100,105,105,13)
	rect(105,104,5,3,13)

	-- deck R
	rect(GERB_SKP_H+64,109,38,7,12)
	-- top
	tri(
		GERB_SKP_H+64,109-10,
		GERB_SKP_H+64,109,
		GERB_SKP_H+64+38,109,
		15)
	tri(
		GERB_SKP_H+64,109-10,
		GERB_SKP_H+64+31,109-10,
		GERB_SKP_H+64+38,109,
		15)
	-- feet
	rect(GERB_SKP_H+63+2,109+7,7,2,14)
	rect(GERB_SKP_H+63+4,109+7,3,2,12)
	rect(GERB_SKP_H+64+2+27,109+7,7,2,14)
	rect(GERB_SKP_H+64+4+27,109+7,3,2,13)
	-- platter
	elli(145,103,15,3,12)
	elli(145,103-2,15,3,0)
	line(145,103-3,145,103-4,13)
	-- tone arm
	line(50+85,101,53+105,105,13)
	rect(53+105,104,5,3,13)

	-- mixer
	rect(120-4,110-5,9,3,2)
	rect(120-5,110-3,11,4,2)
	rect(120-5,110,11,5,13)

	-- hands:
	-- thumb
	rect(lHandX+120-9+9,102-1,5,5,12)
	rectb(lHandX+120-9+9,102-1,5,5,0)
	-- hand
	rect(lHandX+120-9,102-3,11,4,13)
	rectb(lHandX+120-9,102-3,11,4,0)
	-- finger1
	rect(lHandX+120-9,102,6,6,12)
	rectb(lHandX+120-9,102,6,6,0)
	-- finger2
	rect(lHandX+120-9+6,102,6,6,12)
	rectb(lHandX+120-9+6,102,6,6,0)

	-- thumb
	rect(rHandX+120-9-2,rHandY-1,5,5,12)
	rectb(rHandX+120-9-2,rHandY-1,5,5,0)
	-- hand
	rect(rHandX+120-9,rHandY-3,11,4,13)
	rectb(rHandX+120-9,rHandY-3,11,4,0)
	-- finger1
	rect(rHandX+120-9,rHandY,6,6,12)
	rectb(rHandX+120-9,rHandY,6,6,0)
	-- finger2
	rect(rHandX+120-9+6,rHandY,6,6,12)
	rectb(rHandX+120-9+6,rHandY,6,6,0)

	-- cables
	for i=0,16*5 do
		pix(
			112-math.cos(i/26)*7,
			112+math.sin(i/26)*22,
			14)
	end
	for i=0,16*5 do
		pix(
			141-math.cos(i/26)*20,
			112+math.sin(i/26)*15,
			14)
	end

	overlay_defaults((_t-gerbera_st),"01","MOPP")
end

function gerb_speaker(x,y,t)
	rect(x,y,GERB_SKP_H,GERB_SPK_W,15)
	line(
		x+2,y+2,
		GERB_SKP_H+x-4,y+2,
		0)
	line(
		x+2,y+GERB_SPK_W-3,
		GERB_SKP_H+x-3,y+GERB_SPK_W-3,
		14)
	line(
		x+2,y+2,
		x+2,y+GERB_SPK_W-4,
		14)
	line(
		GERB_SKP_H+x-3,y+2,
		GERB_SKP_H+x-3,y+GERB_SPK_W-4,
		0)

	gerb_cone(x+GERB_SKP_H/2,y+24,15,t)
	gerb_cone(x+GERB_SKP_H/2,y+GERB_SPK_W-33,27,t)
end

function gerb_cone(x,y,r,t)
	circ(x,y,r,14)
	circ(x,y,r-3,0)
	gerb_coneGrad(x,y,r-3,t)
	circb(x,y,r-3,15)
	circb(x,y,r-4,13)
	circ(x,y,(r/4)*(1+math.sin(t/10)/12),15)
	circ(x-1,y-1,2,14)
	circ(x-1,y-1,1,13)
	pix(x,y-r+1,0)
	pix(x,y+r-1,0)
	pix(x-r+1,y,0)
	pix(x+r-1,y,0)
end

function gerb_coneGrad(ox,oy,r)
	for x=-r,r do
		for y=-r,r do
			local d=(x^2+y^2)^.5
			if d<=r then
				local c=math.atan2(x,y)
				pix(ox+x,oy+y,14.7+math.sin(c-.5)*1.5
					+(x*2-y%2)%4/4
				)
			end
		end
	end
end
