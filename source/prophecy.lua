----------------------------------------------------
---- project prophecy / conspiracy

-- timings:
local PROPH_T_START_PAN=50
local PROPH_T_PAN_DUR=300
local PROPH_T_SHOW_LOGO=250
local PROPH_T_END_PAN=400
local PROPH_T_END_FLASH_1=PROPH_T_END_PAN+1
local PROPH_T_END_CLOSEUP_1=PROPH_T_END_FLASH_1+100
local PROPH_T_END_FLASH_2=PROPH_T_END_CLOSEUP_1+1
local PROPH_T_END_CLOSEUP_2=PROPH_T_END_FLASH_2+100

local PROPH_PROFILE=false
local PROPH_PARTICLE_COUNT=100
local PROPH_PARTICLE_MAX_Z=8
local PROPH_PARTICLE_SPEED=.04
local PROPH_STAR_COUNT=100
local PROPH_ASTEROID_R=1
local PROPH_ASTEROID_Z=8
local PROPH_EARTH_R=6
local PROPH_EARTH_Z=70
local PROPH_PERSP_LEN=300

local proph_t=0
local proph_camPos={x=0,y=0,z=0}
local proph_camRot={x=0,y=0,z=0}
local proph_stars={}
local proph_particles={}
local proph_noise={}
local proph_noiseSz=256

local proph_st = 0
function prophecy_init()
	sweetie16_init()
	proph_st=_t
	proph_initStars()
	proph_initParticles()
	proph_initNoise()
	proph_initDither()
	salad(1,{banana,apple},2000,2000)
	salad(2,{apple,orange,peach,banana,grapes},3000,1000)
	salad(3,{pear,grapes},4200,1000)
	salad(4,{pineapple,blueberry},3400,3000)
end

function prophecy()
  --local profileStart=time()
  proph_t= (_t-proph_st)/30
  cls()

  -- main scene / pan
	if proph_t<PROPH_T_END_PAN then
		proph_updateParticles()
		proph_updateCam()
		proph_sky()
		proph_earth(0,0,PROPH_EARTH_Z)
		proph_asteroid(0,0,PROPH_ASTEROID_Z)
		-- show logo
		if proph_t>PROPH_T_SHOW_LOGO then
			proph_logo(21,60,(proph_t-PROPH_T_SHOW_LOGO)/50)
		end
		-- flash 1
	elseif proph_t<PROPH_T_END_FLASH_1 then
		cls(12)
		-- closeup 1
	elseif proph_t<PROPH_T_END_CLOSEUP_1 then
		proph_sky()
		local tl=proph_t-PROPH_T_END_FLASH_1
		proph_camPos={x=-2+tl/200,y=-2+tl/200,z=35}
		proph_camRot={x=0,y=0,z=0}
		proph_earth(0,0,PROPH_EARTH_Z)
		-- flash 2
	elseif proph_t<PROPH_T_END_FLASH_2 then
		cls(12)
		-- closeup 2
	elseif proph_t<PROPH_T_END_CLOSEUP_2 then
		proph_sky()
		local tl=proph_t-PROPH_T_END_FLASH_2
		proph_camPos={x=-2+tl/200,y=-2+tl/200,z=55}
		proph_camRot={x=0,y=0,z=0}
		proph_earth(0,0,PROPH_EARTH_Z)
		-- end flash
	else
		cls(12)
	end
  -- profile:
  --print((time()-profileStart)//1,0,0,12)
  
  overlay_defaults((_t-proph_st),"04","CONS")
end

local proph_dither={}
function proph_initDither()
	for x=0,239 do
		proph_dither[x+1]={}
		for y=0,135 do
			proph_dither[x+1][y+1]=(x*2-y%2)%4/4+((x&2)-y//2%2)%4/16
		end
	end
end

function proph_initStars()
  for i=1,PROPH_STAR_COUNT do
    proph_stars[i]={
      math.random(0,239),
      math.random(0,135),
      math.random(12,14),
    }
  end
end

function proph_initParticles()
  math.randomseed(2)
  for i=1,PROPH_PARTICLE_COUNT do
    proph_particles[i]=proph_createParticle()
  end
end

function proph_initNoise()
  math.randomseed(17)
  for octave=1,5 do
    -- Geneate random values
    local values={}
    for i=1,proph_noiseSz^2 do
      values[i]=math.random()
    end

    step=2^octave -- increase step size for each octave in powers of two
    numSteps=proph_noiseSz//step -- number of step repetitions in table
    for y=0,proph_noiseSz-1 do
      for x=0,proph_noiseSz-1 do
        -- Get cells from values grid to interpolate
        x1=(x//step)%numSteps
        y1=(y//step)%numSteps
        x2=(x1+1)%numSteps
        y2=(y1+1)%numSteps
        a=values[x1+y1*numSteps+1] -- upper left cell
        b=values[x2+y1*numSteps+1] -- upper right cell
        c=values[x1+y2*numSteps+1] -- lower left cell
        d=values[x2+y2*numSteps+1] -- lower right cell

        -- 2d interpolation to get current value
        mx=x%step/step
        my=y%step/step
        A=a+(b-a)*mx^2*(3-2*mx) -- smoothstep
        B=c+(d-c)*mx^2*(3-2*mx)
        v=A+(B-A)*my^2*(3-2*my)

        -- Accumulate values for each octave in table
        k=x+y*proph_noiseSz+1
        proph_noise[k]=(proph_noise[k] or 0)+v
        *step -- multiply by step size so magnitude decreases with frequency
      end
    end
  end
end

-- optimisation: inlined
-- function proph_getNoise(x,y)
-- 	return proph_noise[(y%proph_noiseSz)*proph_noiseSz+x%proph_noiseSz+1]
-- end

function proph_updateCam()
  proph_camPos.z=-4*proph_smootherStep(proph_t/400)
  if proph_t>PROPH_T_START_PAN then
    local ss=proph_smootherStep((proph_t-PROPH_T_START_PAN)/PROPH_T_PAN_DUR)
    proph_camPos.x=7*ss
    proph_camPos.y=5.5*ss
    proph_camRot.y=-.328*ss
    proph_camRot.x=-.219*ss
  end
end

function proph_updateParticles()
  for i=1,#proph_particles do
    local p=proph_particles[i]
    p.z=p.z-PROPH_PARTICLE_SPEED
    if p.z<-PROPH_PARTICLE_MAX_Z then
      p.z=p.z+PROPH_PARTICLE_MAX_Z
    end
  end
end

function proph_createParticle()
  while true do
    local x=math.random()*2-1
    local y=math.random()*2-1
    local d=(x^2+y^2)^.5
    if d<1 then
      return {x=x,y=y,z=math.random()*-PROPH_PARTICLE_MAX_Z}
    end
  end
end

function proph_sky()
	local bg=proph_transform({x=proph_t*10,y=0,z=50000-proph_camPos.z})
	proph_clouds(bg)
	for i=1,#proph_stars do
		local p=proph_stars[i]
		pix(
		(p[1]+bg.x)%240,
		(p[2]+bg.y)%136,
		p[3])
	end
end

function proph_clouds(v)
	for y=0,135 do
		local Y=((-y+v.y)%proph_noiseSz)*proph_noiseSz
		for x=0,239 do
			-- optimisation: inlined
			-- if proph_getNoise(-x+v.x,-y+v.y)/35+
			if proph_noise[Y+-(x+v.x)%proph_noiseSz+1]/35+
				proph_dither[x+1][y+1]
				--(x*2-y%2)%4/4+((x&2)-y//2%2)%4/16
				>2 then
				pix(x,y,1)
			end
		end
	end
end

function proph_asteroid(x,y,z)
	local o=proph_vec(x,y,z)
	local v=proph_transform(o)
	local r=proph_project(PROPH_ASTEROID_R,z-proph_camPos.z)

	local atri=function(x1,y1,x2,y2,x3,y3,c)
		tri(
		v.x+x1/100*r,v.y+y1/100*r,
		v.x+x2/100*r,v.y+y2/100*r,
		v.x+x3/100*r,v.y+y3/100*r,
		c)
	end

	circ(v.x,v.y,r/2,12)
	-- main body
	math.randomseed(15)
	for i=0,22 do
		atri(
		math.random(-100,100),
		math.random(-100,100),
		math.random(-100,100),
		math.random(-100,100),
		math.random(-100,100),
		math.random(-100,100),
		math.random(13,15)
		)
	end

	-- trail clouds
	local dist=2
	local v1=proph_transform({x=o.x,y=o.y,z=o.z-dist})
	r=r*3
	local T=proph_t//3
	for Y=math.max(0,v1.y-r),math.min(135,v1.y+r),2 do
		local Y1=(Y/2)%2
		local Y2=(Y-v1.y)^2
		local Y3=(Y+T)%proph_noiseSz
		for X=math.max(0,v1.x-r),math.min(239,v1.x+r),2 do
			local d=((X-v1.x)^2+Y2)^.5
			local D=(1-d/r)
			if d<r then
				local c=D
				-- *proph_getNoise(X+T,Y+T)/7
				*proph_noise[Y3*proph_noiseSz+-(X+T)%proph_noiseSz+1]/7
				+(X-Y1)%4/4
				if c>1 then
					pix(X,Y,7+c)
				end
			end
		end
	end

	-- white clouds
	r=r//2
	for X=math.max(0,v.x-r),math.min(239,v.x+r) do
		local X1=(X-v.x)^2
		local X2=-(X*5-T)%proph_noiseSz+1
		for Y=math.max(0,v.y-r),math.min(135,v.y+r) do
			local d=(X1+(Y-v.y)^2)^.5
			local c=(1-d/r)
			-- *proph_getNoise(X*5+T,Y*5+T)/80
			*proph_noise[((Y*5-T)%proph_noiseSz)*proph_noiseSz+X2]/80
			+(X*2-Y%2)%4/4
			if c>1 then
				pix(X,Y,12)
			end
		end
	end

	-- particles
	for i=1,#proph_particles do
		local pt=proph_transform(
		proph_vecAdd(o,proph_particles[i])
		)
		local pr=proph_project(.01,pt.z-proph_camPos.z)
		circ(pt.x,pt.y,pr,13)
	end
end

function proph_earth(ox,oy,oz)
	local p=proph_transform(proph_vec(ox,oy,oz))
	local r=proph_project(PROPH_EARTH_R,oz-proph_camPos.z)

	local landPal={0,8,9,10,11,12}
	local seaPal={0,8,7,6,5,5}
	local cloudPal={0,15,14,13,12,12}

	for x=math.max(0,p.x-r),math.min(239,p.x+r) do  
		local X=(p.x-x)/r*50//1
		local X0=(x-p.x)^2
		local X1=(x-p.x+r/6)^2
		local X2=(p.x-x)/r*4
		local X3=(x-p.x+r)/r*1.2
		local X4=-(X*3)%proph_noiseSz+1
		local R=r/50/3
		local R1=r/3.5
		for y=math.max(0,p.y-r),math.min(135,p.y+r) do
			local dy=y-p.y
			-- dist from center
			local d=(X0+dy^2)^.5

			if d<r then
				local d1=(X1+(dy+r/5)^2)^.5
				local c=
				-- dist from light center
				(r-d1)/R1+X2+
				-- dither
				--(x*2-y%2)%4/4+((x&2)-y//2%2)%4/16
				proph_dither[x+1][y+1]

				local pal=seaPal
				local Y=dy//R

				-- if proph_getNoise(X+9,Y*6)>37 then
				if proph_noise[((Y*2)%proph_noiseSz)*proph_noiseSz+X4]>37 then
					pal=cloudPal
					-- elseif proph_getNoise(X*3+21,Y*3)>33 then
				elseif proph_noise[(Y%proph_noiseSz)*proph_noiseSz+X4]>30 then
					pal=landPal
				end

				pix(x,y,pal[1+c//1])

			elseif d-r<.8 then
				pix(x,y,12+X3)
			end
		end
	end
end

function proph_logo(x,y,l)
	print("THE",x+90,y-9,12)
	print("PROJECT NEMESIS",x+58,y+21,12)

	local l1=l*2
	if l1<3.14 then
		rect(0,y,240,2,8+math.sin(l1)*2)
		rect(0,y+7,240,2,8+math.sin(l1)*3)
	end

	if l<1 then
		proph_text(x-40*(1-l),y,l,3)
		proph_text(x-20*(1-l),y,l,4)
	end
	proph_text(x,y,l,12)
end

function proph_text(x,y,l,c)
	local w=23
	local h=16

	clip(x,y,200*l,h)
	-- p
	rect(x+0,y+0,w,2,c)
	rect(x+0,y+7,w,2,c)
	rect(x+0,y+0,2,h,c)
	rect(x+w-2,y+0,2,h/2,c)
	x=x+25
	-- r
	rect(x+0,y+0,w,2,c)
	rect(x+0,y+7,w,2,c)
	rect(x+0,y+0,2,h,c)
	rect(x+w-2,y+0,2,h/2,c)
	rect(x+w-4,y+h/2,2,h/2,c)
	x=x+25
	-- o
	rect(x+0,y+0,w,2,c)
	rect(x+0,y+0,2,h,c)
	rect(x+0,y+h-2,w,2,c)
	rect(x+w-2,y+0,2,h,c)
	x=x+25
	-- p
	rect(x+0,y+0,w,2,c)
	rect(x+0,y+7,w,2,c)
	rect(x+0,y+0,2,h,c)
	rect(x+w-2,y+0,2,h/2,c)
	x=x+25
	-- h
	rect(x+0,y+7,w,2,c)
	rect(x+0,y+0,2,h,c)
	rect(x+w-2,y+0,2,h,c)
	x=x+25
	-- e
	rect(x+0,y+0,w,2,c)
	rect(x+0,y+7,w,2,c)
	rect(x+0,y+0,2,h,c)
	rect(x+0,y+h-2,w,2,c)
	x=x+25
	-- c
	rect(x+0,y+0,w,2,c)
	rect(x+0,y+0,2,h,c)
	rect(x+0,y+h-2,w,2,c)
	x=x+25
	-- y
	rect(x+0,y+0,2,h/2,c)
	rect(x+0,y+7,w,2,c)
	rect(x+w-2,y+0,2,h/2,c)
	rect(x+w/2-1,y+h/2,2,h/2,c)
	clip()
end

function proph_vecProject(v)
	return {
		x=120+(v.x*PROPH_PERSP_LEN/v.z)//1,
		y=68+(v.y*PROPH_PERSP_LEN/v.z)//1,
		z=v.z,
	}
end

function proph_project(v,z)
	return (v*PROPH_PERSP_LEN/z+.5)//1
end

function proph_transform(p)
	return proph_vecProject(
		proph_vecRotate(
			proph_vecSub(p,proph_camPos),proph_camRot
		)
	)
end

function proph_vec(x,y,z)
	return {x=x,y=y,z=z}
end

function proph_vecAdd(v1,v2)
	return {
		x=v1.x+v2.x,
		y=v1.y+v2.y,
		z=v1.z+v2.z,
	}
end

function proph_vecSub(v1,v2)
	return {
		x=v1.x-v2.x,
		y=v1.y-v2.y,
		z=v1.z-v2.z,
	}
end

function proph_vecRotate(p,r)
	local Sx=math.sin(r.x)
	local Cx=math.cos(r.x)
	local Sy=math.sin(r.y)
	local Cy=math.cos(r.y)
	local Sz=math.sin(r.z)
	local Cz=math.cos(r.z)
	-- rotate z
	local x1=-Sz*p.y+Cz*p.x
	local y1=Sz*p.x+Cz*p.y
	--	rotate y
	local x2=-Sy*p.z+Cy*x1
	local z1=Sy*x1+Cy*p.z
	-- rotate x
	local y2=-Sx*z1+Cx*y1
	local z2=Sx*y1+Cx*z1
	return {x=x2,y=y2,z=z2}
end

function proph_smootherStep(x)
	x=math.max(0,math.min(1,x))
	return x*x*x*(3*x*(2*x-5)+10)
end