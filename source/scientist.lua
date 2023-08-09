
local SC={}

function ScDrawEyes(xC,y,w,eyeRatio)
	for iE=-1,1,2 do
		local x=xC+iE*w*.2
		elli(x,y,8,8*eyeRatio,12)
		circ(x,y,3,0)
	end
end

-- p:
--  mouth: 0-1
function ScDrawFace1(xC,yNeck,w,h,t,p)
	local yTop=yNeck-h

	-- suit
	rect(xC-w*.5,yNeck,w,h,9)

	local jawH=h*.2
	local headBottomY=yNeck-jawH
	local mouthGapY=p.mouth*h*.1+1
	local mouthJawTopY=yNeck-jawH+mouthGapY

	-- mouth
	rect(xC-w*.4,headBottomY,w*.8,mouthGapY,1)

	-- head
	rect(xC-w*.4,yTop,w*.8,headBottomY-yTop,4)
	
	-- jaw
	rect(xC-w*.4,mouthJawTopY,w*.8,h*.2,4)

	ScDrawEyes(xC,yNeck-h*.6,w,.5)

	local xParting=xC-w*.2
	local yHair=yTop+h*.2
	local x0=xC-w*.6
	local x1=xC+w*.6
	tri(x0,yTop,x0,yHair,xParting,yTop,0)
	tri(x1,yTop,x1,yHair,xParting,yTop,0)
end

function ScDrawFace2(xC,yNeck,w,h,t,p)
	tri(xC-w*.5,yNeck,xC+w*.5,yNeck,xC,yNeck+h,5)

	elli(xC,yNeck-h*.3,w*.6,w*.5,4)

	ScDrawEyes(xC,yNeck-h*.4,w,1.25)

	local mR=p.mouth*10+2
	circ(xC,yNeck-h*.1,mR,2)
	circ(xC+w*.2,yNeck-h*.7,10,0)
end

function ScDrawFace3(xC,yNeck,w,h,t,p)
	local zoomIt=1
	if SC.meltdownTime>.6 then
		local zoomIn=(SC.meltdownTime-.6)/.4
		zoomIt=1+zoomIn*2
		xC=xC-zoomIn*30
		yNeck=yNeck+zoomIn*10
	end
	w=w*zoomIt
	h=h*zoomIt
	elli(xC,yNeck+h*1.2,w*.8,h*1.5,12)

-- Correct this...
	yC=yNeck-h*.5+math.abs(math.sin(p.mouth*.3))*2


	local tuftLX=xC-w*.48
	local tuftLY=yC-h*.2
	local tuftRX=xC+w*.48
	local tuftRY=yC-h*.2
	if p.face==1 then
		local px1,py1=xC-w*.4,yC-h*.3
		local px2,py2=xC+w*.4,yC+h*.5
		local fnJiggleLine=function(x0,y0,x1,y1,c)
			line(x0+math.random(-3,3),y0+math.random(-3,3),x1+math.random(-3,3),y1+math.random(-3,3),c)
		end

		for i=0,4 do
			fnJiggleLine(px1,py1,px2,py1,4)
			fnJiggleLine(px2,py1,px2,py2,4)
			fnJiggleLine(px1,py2,px2,py2,4)
			fnJiggleLine(px1,py1,px1,py2,4)
		end
		tuftLY=tuftLY+math.random(-3,3)
		tuftRY=tuftRY+math.random(-3,3)
	elseif p.face==2 then
		rect(xC-w*.4,yC-h*.5,w*.8,h,4)
	elseif p.face==3 then
		-- circle
		local yBounce=math.abs(math.sin(t*.1))*5
		circ(xC,yC+h*.1-yBounce,w*.6,4)
		tuftLY=tuftLY-yBounce
		tuftRY=tuftRY-yBounce
	elseif p.face==4 then
		local fnRotPoint=function(xc,yc,a,d)
			return xc+math.sin(a)*d,yc+math.cos(a)*d
		end

		local rot=t*.03
		local yTri=yC+h*.08
		local d=(w+h)*.4
		local x1,y1=fnRotPoint(xC,yTri,rot,d)
		local x2,y2=fnRotPoint(xC,yTri,rot+math.pi*2/3,d)
		local x3,y3=fnRotPoint(xC,yTri,rot+math.pi*4/3,d)
		tri(x1,y1,x2,y2,x3,y3,4)

		tuftLX=(x1+x2)/2
		tuftLY=(y1+y2)/2
		tuftRX=(x2+x3)/2
		tuftRY=(y2+y3)/2
	elseif p.face==5 then
		local faceH=h*(1+.3*math.sin(t*.1))
		local faceW=w*(1+.2*math.sin(t*.12))
		elli(xC,yC+h*.1,faceW*.5,faceH*.5,4)
		tuftLX=tuftLX+w*.1-(faceW)*.1
		tuftRX=tuftRX-w*.1+(faceW)*.1
	else
		elli(xC,yC,w*.5,h*.5,4)
	end

	elli(tuftLX,tuftLY,4*zoomIt,10*zoomIt,12)
	elli(tuftRX,tuftRY,4*zoomIt,10*zoomIt,12)

	ScDrawEyes(xC,yC,w*zoomIt,zoomIt)

	if(SC.meltdownTime>.55)then
		local zoomIn=(SC.meltdownTime-.55)/.44
		p.mouth=p.mouth*(1-zoomIn)+zoomIn
	end

	local mW=.1+(w*.2)*p.mouth*1.4
	local mH=h*.1*p.mouth

	if(SC.meltdownTime>.55)then
		local zoomIn=(SC.meltdownTime-.55)/.44
		mW=mW*(1+zoomIn*4)
		mH=mH*(1+zoomIn*4)
	end

	elli(xC,yC+h*.3+(zoomIt-1)*10,mW,mH,0)
end

function ScDoLabel()
	if SC.nameText==nil then
		return
	end

	local unitPos=1
	if SC.nameTime<.1 then
		unitPos=(SC.nameTime/.1)
	elseif SC.nameTime>.8 then
		unitPos=1-(SC.nameTime-.8)/.1
	end

	local x=240-unitPos*150
	local yc=120
	local x1,x2,y1,y2=x+10,x-12,yc-10,yc+12
	tri(x1,y1,240,y1,240,y2,1)
	tri(240,y2,x2,y2,x1,y1,1)
	local tx,ty=x+15,yc-8
	print(SC.nameText,tx+1,ty+1,0,false,2)
	print(SC.nameText,tx,ty,12,false,2)

	print(SC.nameSubtext,tx+1,ty+13,0)
	print(SC.nameSubtext,tx,ty+12,12)

	SC.nameTime=SC.nameTime+.004
	if SC.nameTime>=1 then
		SC.nameText=nil
	end
end

function ScSplitString(text)
	lines = {}
	for s in text:gmatch("[^\r\n]+") do
		table.insert(lines, s)
	end
	return lines
end

function ScDoSpeech()
	if SC.speechText==nil then
		return
	end

	local isLower=(SC.starSpeaking==2)
	local x=SC.speechX-SC.camX
	local y=6 + (isLower and 10 or 0)

	-- TIC can do multiline, but vertical spacing is tight, so here's a custom function
	local lines=ScSplitString(SC.speechText)
	local tw=0
	for i,line in ipairs(lines) do
		local lineW=print(line,240,0,0,false,SC.speechZoom)
		tw=math.max(tw,lineW)
	end

	local mX=5
	local mY=4
	local lineH=6*SC.speechZoom
	local lineYgap=3
	local h=mY*2+#lines*lineH+(#lines-1)*lineYgap
	local w=tw+mX*2

	local stickShiftX=SC.speechXFlip and -30 or 30

	tri(x+w/2,y+h,x+w/2+stickShiftX/2,y+h,x+w/2+stickShiftX,y+h+20,12)
	rect(x,y,w,h,12)

	local yText=y+mY
	for i,line in ipairs(lines) do
		print(line,x+mX,yText,0,false,SC.speechZoom)
		yText=yText+lineH+lineYgap
	end

	SC.speechTime=SC.speechTime+.01
	if SC.speechTime>=1 then
		SC.speechText=nil
	end
end

function ScDrawBg(camX,t)
	for y=0,135 do
		for x=0,239 do
			local c=3
			if y<120 then
				c=2+11*(((x+camX*.5)//32+y//32)%2)
			end
			poke4(y*240+x,c)
		end
	end
end

function ScDrawScreen(x,y,w,h,image,t)
	local srcW,srcH=120,68
	vbank(1)

	if SC.meltdownTime>0 then
		for py=0,srcH do
			for px=0,srcW do
				pix(px,py,math.random(12,15))
			end
		end
	else
		if image==1 then
			-- pixels
			rect(0,0,119,67,0)
			for py=0,68,6 do
				for px=0,119,6 do
					local c=10+math.sin(px^2+t*.23)*2+math.sin(py+t*.1)*2
					rect(px,py,3,3,c)
				end
			end
		elseif image==2 then
			-- colours
			rect(0,0,119,67,0)
			for i=1,15 do
				rect(i*8-6,34+math.sin(t*.05+i*.3)*30,4,4,i)
			end
		elseif image==3 then
			-- sprites
			for i=1,15 do
				local px=60+math.sin(t*.04+i*.5)*50
				local py=34+math.sin(t*.025+i*.6)*30
				rect(px,py,4,4,1+i%3)
			end
		else
			--ident
			for px=0,119 do
				for py=0,67 do
					pix(px,py,(((px+py+t)>>6)%3)*4+2)
				end
			end
			print("ASM",13,13,0,false,6)
			print("ASM",11,11,12,false,6)
			print("TV",82,47,0,false,3)
			print("TV",80,45,12,false,3)
		end
	end
-- Static
--[[
	for py=0,w-1 do
		for px=0,w-1 do
			pix(px,py,math.random(12,15))
		end
	end
--]]

	vbank(0)
	local pulse=1
	if image==4 then
		-- sound
		pulse=math.sin(t*.2)
		pulse=pulse>0 and 1+pulse*.2 or 1
		w=w*pulse
		h=h*pulse
	end
	y=y-(pulse-1)*50
	local pX0,pY0,pX1,pY1=x-w/2,y-h/2,x+w/2,y+h/2

	local leanY=-1
	local leanX=0
	local p0x,p0y,p1x,p1y=pX0-leanY,pY0-leanX,pX1+leanY,pY0+leanX
	local p2x,p2y,p3x,p3y=pX1-leanY,pY1+leanX,pX0+leanY,pY1-leanX

	tri(p0x-2,p0y-2,p1x+2,p1y-2,p2x+2,p2y+2,15)
	tri(p2x+2,p2y+2,p3x-2,p3y+2,p0x-2,p0y-2,15)
	ttri(p0x,p0y,p1x,p1y,p2x,p2y,0,0,srcW,0,srcW,srcH,2)
	ttri(p2x,p2y,p3x,p3y,p0x,p0y,srcW,srcH,0,srcH,0,0,2)

	vbank(1)
	cls()

	vbank(0)
end

function ScCamToStar(i,isSpeaking)
	local posns={
		SC.starX[1] + (isSpeaking and 60 or 0),
		SC.starX[2] + (isSpeaking and -60 or 0),
		SC.starX[3] + (isSpeaking and -60 or 0),
	}
	SC.camXAim=posns[i]
	SC.starSpeaking=i
end

function ScDoMeltdown()
	if(SC.meltdownTime==0) then
		return
	end

	local screenShake=SC.meltdownTime*math.random(0,4)
	poke(0x3FF9,screenShake)
	SC.meltdownTime=math.min(1,SC.meltdownTime+0.004)
end

function ScDoSprite()
	if not SC.showSprite then
		return
	end

	-- SHOW SPRITE
	spr(224,120-64,60,-1,1,0,0,16,2)
end

-- w: wait (w=?)
-- n: name (n=?)
-- c: camera (c=[character])
-- s: say (c=[character],s=[speech]) - includes camera movement
-- sf: scientist face (f=1-4)
-- tv: tv image (i=1-4)
-- Characters: 1=Mick McAtee, 2=Katie O'Tic, 3=Scienticst
-- scene: 1 or 2
function ScInit(scene,pos)
	SC={
		runTime=0,
		scriptPos=pos,
		scriptTNext=0,
		screenX=70,
		screenY=100,
		screenW=80,
		screenH=50,
		screenImage=0,
		starX={-140,0,300},
		starSpeaking=nil,
		speechText=nil,
		speechTime=0,
		speechZoom=1,
		speechX=nil,
		speechXFlip=nil,
		nameText=nil,
		nameSubtext=nil,
		nameTime=0,
		scientistFace=0,
		meltdownTime=0,
	}

	if scene==1 then
		SC.camX=(SC.starX[1]+SC.starX[2])/2
		SC.camXAim=SC.camX
		SC.script={
			{t='s',c=1,s="So that's why you never\ntravel without a spork!"},
			{t='n',n="Katie O'Tic",s='(TV Presenter)'},
			{t='s',c=2,s="Thanks, Mick. Next up, TIC-80"},
			{t='s',c=2,s="TIC-80 is a 'fantasy console'."},
			{t='n',n="Mick McAtee",s='(Also a TV presenter)'},
			{t='s',c=1,s="Like a pretend computer, Katie!"},
			{t='s',c=1,s="Over to our expert!"},
			{t='n',n="A Scienticst",s='(Resident Hexpert)'},
			{t='s',c=3,s="Yes. Ha. YES!"},
			{t='s',c=3,s="Like an old computer\non a new computer!"},
			{t='w',w=1},
			{t='tv',i=1},
			{t='s',c=3,s="It has a 240 by 136 pixel screen",d=1.8},
			{t='tv',i=2},
			{t='s',c=3,s="16 colours in a\ncandy-style palette",d=1.8},
			{t='tv',i=3},
			{t='s',c=3,s="Some tiny sprites. Wheeee!",d=1.8},
			{t='tv',i=4},
			{t='s',c=3,s="Crunchy sound effects\nAnd four channel bloopy music",d=1.8},
			{t='tv',i=0},
			{t='w',w=1},
			{t='sf',f=1},
			{t='s',c=3,s="It can do basic shapes, like lines:"},
			{t='sf',f=2},
			{t='s',c=3,s="Rectangles",d=.6},
			{t='sf',f=4},
			{t='s',c=3,s="Triangles",d=.6},
			{t='sf',f=3},
			{t='s',c=3,s="Circles",d=.6},
			{t='sf',f=5},
			{t='s',c=3,s="Squashy Circles",d=.6},
			{t='sf',f=0},
			{t='s',c=3,s="And text, of course."},
			{t='s',c=2,s="Of course!"},
			{t='s',c=1,s="Of course?"},
			{t='s',c=3,s="Of course!"},
			{t='w',w=80},
			{t='s',c=3,s="Of course\nNONE of this actually matters.",d=1.2},
			{t='s',c=2,s="What..?"},
			{t='s',c=3,s="You dweebs heard of the\nsimulation hypothesis?"},
			{t='s',c=1,s="Uhh...?",z=2,d=.5},
			{t='s',c=3,s="The idea that we're all\njust characters"},
			{t='s',c=3,s="In a big\ncomputer\nsimulation?"},
			{t='s',c=3,s="And This simulation makes us"},
			{t='s',c=3,s="An experiment."},
			{t='m'},
			{t='s',c=3,s="Or WORSE..."},
			{t='s',c=3,s="We're just here for someone's",d=.8},
			{t='s',c=3,s="SICK",z=3,d=.8},
			{t='s',c=3,s="ENTERTAINMENT",z=2,d=.7},
			{t='s',c=3,s="ENTERTAINMENT",z=2,d=.5},
			{t='w',w=20},
			{t='spr'},
			{t='w',w=100},
			{t='w',w=1},
		}
	end
end

-- w: wait (w=?)
-- n: name (n=?)
-- c: camera (c=[character])
-- s: say (c=[character],s=[speech]) - includes camera movement
-- Characters: 1=Mick McAtee, 2=Katie O'Tic, 3=Scienticst
sc_st=0
function scientist_init()
	sc_st = _t
	sweetie16_init()
	ScInit(1,0)
end

function scientist_init2()
	sc_st = _t
	sweetie16_init()
	ScInit(1,11)
end

function scientist_init3()
	sc_st = _t
	sweetie16_init()
	ScInit(1,20)
end
--[[
function scientist_init4()
	sc_st = _t
	sweetie16_init()
	ScInit(1,23)
end
--]]
function scientist_init5()
	sc_st = _t
	sweetie16_init()
	ScInit(1,37)
end

function scientist()
	
local T=(_t-sc_st)
	
	if SC.showSprite then
		cls(0)
		ScDoSprite()
	else
	-- Lerp camera...
		SC.camX=SC.camX+(SC.camXAim-SC.camX)*.08

		ScDrawBg(SC.camX,SC.runTime)
		ScDrawScreen(SC.screenX-SC.camX*.5+120,SC.screenY,SC.screenW,SC.screenH,SC.screenImage,SC.runTime)

		if SC.meltdownTime>0 then
			for i=1,SC.meltdownTime*30//1 do
				rect(math.random(-8,236),math.random(-8,132),math.random(10,80),math.random(10,80),math.random(13,15))
			end
		end

		ScDrawFace1(SC.starX[1]-SC.camX+120,110,60,80,SC.runTime,{
			mouth=(SC.starSpeaking==1) and math.abs(math.sin(SC.runTime/8)) or 0
		})

		ScDrawFace2(SC.starX[2]-SC.camX+120,110,60,80,SC.runTime,{
			mouth=(SC.starSpeaking==2) and math.abs(math.sin(SC.runTime/8)) or 0
		})

		ScDrawFace3(SC.starX[3]-SC.camX+120,110,60,80,SC.runTime,{
			mouth=(SC.starSpeaking==3) and math.abs(math.sin(SC.runTime/8)) or 0,
			face=SC.scientistFace,
		})

		if SC.scriptTNext==0 then
			SC.scriptPos=SC.scriptPos+1
			local scriptItem=SC.script[SC.scriptPos]
			if scriptItem.t == 'w' then	-- wait
				SC.scriptTNext=scriptItem.w
			elseif scriptItem.t == 'n' then	-- name
				SC.nameText=scriptItem.n
				SC.nameSubtext=scriptItem.s
				SC.nameTime=0
			elseif scriptItem.t == 'c' then	-- camera
				ScCamToStar(scriptItem.c)
			elseif scriptItem.t == 's' then	-- speak
				ScCamToStar(scriptItem.c,true)
				SC.speechX=SC.starX[scriptItem.c]+((SC.starSpeaking==1) and 120 or -20)
				SC.speechXFlip=(SC.starSpeaking==1)

				SC.speechText=scriptItem.s
				SC.speechTime=0
				SC.speechZoom=scriptItem.z or 1
				local duration=scriptItem.d and scriptItem.d or 1
				SC.scriptTNext=70*duration
			elseif scriptItem.t == 'sf' then
				SC.scientistFace=scriptItem.f
			elseif scriptItem.t == 'tv' then
				SC.screenImage=scriptItem.i
			elseif scriptItem.t == 'm' then
				SC.meltdownTime=0.01
			elseif scriptItem.t == 'spr' then
				SC.showSprite=true
			end
		else
			SC.scriptTNext=SC.scriptTNext-1
		end

		ScDoSpeech()
		ScDoLabel()
		ScDoMeltdown()
	end

	SC.runTime=SC.runTime+1

	overlay_defaults((_t - sc_st), "69", "HOT")
end
