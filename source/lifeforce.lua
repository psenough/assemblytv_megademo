
---------------------------------------
-- lifeforce

function stars(scrolly)
	math.randomseed(1)
	for i=0,1000 do
		circ(math.random(240),
							(math.random(136)+scrolly)%136,
							math.random()*1.5,
							(4+math.random(2)//1*8)*math.abs(math.sin(_t/math.random(2000))//1)
							)
	end
end

function moon(moonposx,moonposy,w)
		circ(moonposx  ,moonposy  ,w   ,13)
		local rndseed = 51
		local craters = 18
		math.randomseed(rndseed)
		for i=0,craters do
			local px=moonposx+w*(math.random()-.5)
			local py=moonposy+w*(math.random()-.6)
			local ww=w*(math.random()*.4+.05)*.6
		 circ(px,py,ww,14)
		end
end

lifeforce_st=0

function lifeforce_init()
	lifeforce_st=_t
	sweetie16_init()
	salad(1,{kiwi,pear,apple},4000,2000)
	salad(2,{apple,orange,blueberry,grapes},3000,1000)
	salad(3,{pear,apple,kiwi,pineapple},2200,1000)
	salad(4,{pineapple,cherry,papaya,mango,fig},2000,3000)
end

function lifeforce()
	local t=(_t-lifeforce_st)
	local fleshColor=14
	local rockColor=8
	local speed=0.09

	cls(0)
	stars(0)

	finger=function(x1,y1,ang,len,rec)
		local fX=mSin(ang)
		local fY=mCos(ang)
		local rX=fY
		local rY=fX
		local x2=x1+fX*len
		local y2=y1-fY*len
		local thick=3+rec*1
		local xl1=x1-rX*thick
		local yl1=y1-rY*thick
		local xr1=x1+rX*thick
		local yr1=y1+rY*thick
		local xl2=x2-rX*thick
		local yl2=y2-rY*thick
		local xr2=x2+rX*thick
		local yr2=y2+rY*thick
		circ(x1,y1,2,fleshColor)
		tri(xl1,yl1,xl2,yl2,xr1,yr1,fleshColor)
		tri(xr2,yr2,xr1,yr1,xl2,yl2,fleshColor)
		circ(x2,y2,2,fleshColor)
		if rec>0 then
			finger(x2,y2,ang*.5,len*.6,rec-1)
		end
	end

	local ta=(t+8000)/1000*speed

	local moonRise
	local handRise
	local clench
	if ta<.6 then
		moonRise=(ta-.4)/.2
		handRise=0
		clench=0
	elseif ta<.8 then
		moonRise=1
		handRise=0
		clench=0
	elseif ta<.9 then
		moonRise=1
		handRise=(ta-.8)/.1
		clench=(1-handRise)^.4
	else
		moonRise=1-((ta-.9)/.1)
		handRise=moonRise*.5+.5
		clench=0
	end

	moon(113,mLerp(moonRise,130,55),20)

	local x=120
	local y=mLerp(handRise,200,50)
	rect(x-20,y,30,30,fleshColor)
	rect(x-10,y+30,20,30,fleshColor)
	finger(x-22,y+20,-.5*clench-.4,12,2)
	finger(x-20,y+5,-.2*clench,mLerp(clench,8,20),2)
	finger(x-10,y,-0.1*clench,mLerp(clench,9,25),2)
	finger(x,y+3,.2*clench,mLerp(clench,9,20),2)
	finger(x+10,y+5,.5*clench,mLerp(clench,8,12),2)
	tri(x-10,y+4,x-28,y+10,x-7,y+60,fleshColor)
	tri(x+15,y+5,x+5,y+5,x+10,y+50,fleshColor)

	tri(10,100,20,60,80,100,rockColor)
	rect(90,95,30,5,rockColor)
	tri(140,100,170,90,175,100,rockColor)
	rect(190,90,5,10,rockColor)
	tri(200,100,210,60,260,100,rockColor)

	rect(0,100,240,100,15)
	for y=1,36,1 do
		for x=0,239 do
			local c=pix((x-120)*(1-(y/300))+120,99-y+mSin(t*.007+y)*2)
			pix(x,99+y,c-y%2)
		end
	end
	
	overlay_defaults(t,"07","ASD")
end
