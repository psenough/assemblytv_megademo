
---------------------------------
--- melon i feel like a computer

-- perspective
IFLAC_PERSP_DIST=18
IFLAC_PERSP_LEN=300
-- voxel grid
IFLAC_VOX_MAX_Z=50
IFLAC_VOX_SIZE=12
-- start frames (/300)
IFLAC_P2_START=33
IFLAC_P3_START=49

feel_st = 0

function feel_like_computer_init()
	feel_st=_t
	sweetie16_init()
	--sync(8 | 16, 3)
	salad(1,{watermelon},1000,2000)
	salad(2,{watermelon,apple,orange},4000,2000)
	salad(3,{watermelon},5000,2000)
	salad(4,{meat},12000,2000)
end

function feel_like_computer()
	local t=(_t-feel_st)/300
	cls(11)

	if t<IFLAC_P2_START then
		iflac_p1(t)
	elseif t<IFLAC_P3_START then
		iflac_p2(t)
	else
		iflac_p3(t)
	end

	overlay_defaults((_t-feel_st),"33","MLON")
end

function iflac_p1(t)
	iflac_drawClouds(t)

	local boatZ=t -- boat z
	local rainbowZ=t+15 -- rainbow z
	local zFract=t%1 -- z fractional part

	-- sea behind boat:
	iflac_seaRange(IFLAC_VOX_MAX_Z,IFLAC_VOX_MAX_Z-boatZ,12,zFract,t)

	-- boat position:
	local boatY=math.sin(t/2)*7+
 		math.sin(t/3)*12+20+
		math.sin((IFLAC_VOX_MAX_Z-boatZ)/2+t/3)*5
	local realBoatZ=(IFLAC_VOX_MAX_Z-boatZ)*IFLAC_VOX_SIZE
	local boatP=(IFLAC_PERSP_LEN/(realBoatZ+IFLAC_PERSP_DIST))
	local boatPos={
		x=120+100*boatP,
		y=68+(boatY-10)*boatP,
	}

	iflac_drawBoat(
		120,
		boatPos.y,
		math.sin(t/5)/6,
		boatPos.x/200)

	-- sea in front of boat
	iflac_seaRange(IFLAC_VOX_MAX_Z-boatZ,IFLAC_VOX_MAX_Z-rainbowZ,12,zFract,t)

	-- draw rainbow
	if t>12 then
		iflac_rainbow(120,120,
			70*IFLAC_PERSP_LEN/((IFLAC_VOX_MAX_Z-rainbowZ)*IFLAC_VOX_SIZE+IFLAC_PERSP_DIST),
			(t-12)/10)
	end

	-- sea in front of rainbow
	iflac_seaRange(IFLAC_VOX_MAX_Z-rainbowZ,0,12,zFract,t)
end

function iflac_p2(t)
	-- sea behind boat:
	local y=iflac_seaRange(IFLAC_VOX_MAX_Z,15,20,0,t)
	-- dog on boat
	iflac_drawDog(120,y-16,1)
	iflac_drawBoat(-60,y+24,0,8)
	-- sea in front of boat
	iflac_seaRange(15,0,20,0,t)
end

function iflac_p3(t)
	-- sea behind boat:
	iflac_seaRange(IFLAC_VOX_MAX_Z,1,20,0,t)
	-- dog
	iflac_drawDog(-10,-20,7)
	if t>IFLAC_P3_START+10 and t<IFLAC_P3_START+12 then
		rect(50,25,140,60,2)
		rect(9*7-10,12*7-20,6*7,7,0)
		rect(22*7-10,12*7-20,6*7,7,0)
	end
	-- sea in front of boat
	iflac_seaRange(1,0,20,0,t)
end

function iflac_seaRange(z1,z2,yRange,offset,t)
 local y=0
 local ys=math.sin(t/3)*yRange+20
	for z=z1,z2,-1 do
		local zs=math.sin(z/2+t/3)*5
		local Z=z*IFLAC_VOX_SIZE
		for x=-11,-1 do
			y=math.sin(x/2+t/2)*7+zs+ys
			iflac_vox(x*IFLAC_VOX_SIZE,y,Z)
		end
		for x=11,0,-1 do
			y=math.sin(x/2+t/2)*7+zs+ys
			iflac_vox(x*IFLAC_VOX_SIZE,y,Z)
		end
	end
 return y
end

function iflac_vox(x,y,z)
	local size=IFLAC_VOX_SIZE/2
	local p1=(IFLAC_PERSP_LEN/(z-size+IFLAC_PERSP_DIST))
	local p2=(IFLAC_PERSP_LEN/(z+size+IFLAC_PERSP_DIST))
	local x1=120+(x-size)*p1
	local x2=120+(x+size)*p1
	local y1=68+(y-size)*p1
	local y2=z>IFLAC_VOX_SIZE and 68+y*p1 or 136
	local x3=120+(x-size)*p2
	local x4=120+(x+size)*p2
	local y3=68+(y-size)*p2
	local y4=68+y*p2

	if x<0 then
	 -- right face
		tri(x2,y1,x2,y2,x4,y3,8)
		tri(x2,y2,x4,y4,x4,y3,8)
	else
		-- left face
		tri(x1,y2,x3,y3,x3,y4,8)
		tri(x3,y3,x1,y2,x1,y1,8)
	end
	if y>size then
	 -- top face
		tri(x1,y1,x2,y1,x4,y3,9)
		tri(x3,y3,x1,y1,x4,y3,9)
	end
	-- front face
	tri(x1,y1,x1,y2,x2,y1,10)
	tri(x2,y1,x1,y2,x2,y2,10)
end

function iflac_drawClouds(t)
  local clouds={{-29,0},{-10,-10},{25,-10},{35,-20},{-39,-9},{-11,-10},{10,-19},{11,0},{26,-10},{20,-1}}
	for i=1,#clouds do
		iflac_cloud3d(clouds[i][1],clouds[i][2],
			(IFLAC_VOX_MAX_Z-t)+i*10)
	end
end

function iflac_cloud3d(x,y,z)
	local Z=IFLAC_PERSP_LEN/(z+IFLAC_PERSP_DIST)
	iflac_cloud(x*Z,y*Z,Z/3,13)
	iflac_cloud(x*Z+1,y*Z-1,Z/3,12)
end

function iflac_cloud(x,y,scale,color)
	local parts={
		{0,4,5},
		{-7,3,4},
		{7,3,5},
		{-12,0,3},
		{11,1,5},
		{-5,-3,5},
		{5,-2,7}
	}
	for i=1,#parts do
    circ(
      120+(x+parts[i][1])*scale,
      68+(y+parts[i][2])*scale,
      parts[i][3]*scale,color)
	end
end

function iflac_rainbow(cx,cy,r,progress)
	local w=r/15 -- width of strip
	local minR=r-4*w
 local colors={9,2,4,5}
	for x=math.max(0,cx-r),math.min(239,cx+r) do
		local xsq=(x-cx)^2
		for y=math.max(0,cy-r),math.min(135,cy) do
			-- optimisation: check distance range first
			local d=(xsq+(y-cy)^2)^.5
			if d<r and d>minR then
				-- limit angle to progressively draw arc
				local a=progress<1 and (-math.atan2(x-cx,y-cy)+math.pi*1.5)%(math.pi*2) or 1
				if a>0 and a<math.pi*progress then
				 -- dist from origin
					for i=1,4 do
						-- bounds of stripe
						if d<r-((i-1)*w) and d>r-(i*w) then
							pix(x,y,colors[i])
							break
						end
					end
				end
			end
		end
	end
end

function iflac_drawBoat(x,y,rot,scale)
	local S=math.sin(rot)*scale
	local C=math.cos(rot)*scale
	-- rotated triangle
	local rtri = function(x1,y1,x2,y2,x3,y3,c)
		tri(
			x+C*x1+S*y1,y+C*y1-S*x1,
			x+C*x2+S*y2,y+C*y2-S*x2,
			x+C*x3+S*y3,y+C*y3-S*x3,
			c
		)
	end

	-- hull
	rtri(
		-30,0,
		-20,12,
		-20,0,
		0
	)
	rtri(
		30,0,
		20,12,
		20,0,
		0
	)
	rtri(
		20,12,
		20,0,
		-20,12,
		0
	)
	rtri(
		-20,0,
		-20,12,
		20,0,
		0
	)
	-- main
	rtri(
		18,-7,
		18,0,
		-18,-7,
		12
	)
	rtri(
		-18,0,
		-18,-7,
		18,0,
		12
	)
	-- funnel l
	rtri(
		4-10,-14,
		4-10,-7,
		-4-10,-14,
		2
	)
	rtri(
		-4-10,-7,
		-4-10,-14,
		4-10,-7,
		2
	)
	-- funnel mid
	rtri(
		4,-14,
		4,-7,
		-4,-14,
		2
	)
	rtri(
		-4,-7,
		-4,-14,
		4,-7,
		2
	)
	-- funnel r
	rtri(
		4+10,-14,
		4+10,-7,
		-4+10,-14,
		2
	)
	rtri(
		-4+10,-7,
		-4+10,-14,
		4+10,-7,
		2
	)
	-- dog
	if scale<5 then
		rtri(
			1+24,-2,
			1+24,0,
			-1+24,-2,
			2
		)
		rtri(
			-1+24,0,
			-1+24,-2,
			1+24,0,
			2
		)
	end
 -- smoke
	for i=0,2 do
		local p=i+time()/1500%1
		local x1=-10+p*7
		local y1=-16-p*6
		circ(
			x+C*x1+S*y1,
			y+C*y1-S*x1,
			(2+p)*scale,
			13)
	end
end

iflac_dog={{{7,2,2}},{{6,4,2}},{{5,6,2},{26,5,2}},{{4,8,2},{13,10,2},{24,8,2}},{{3,30,2}},{{2,32,2}},{{1,9,2},{10,4,12},{14,21,2}},{{1,8,2},{9,6,12},{15,7,2},{22,5,12},{27,8,2}},{{0,9,2},{9,3,12},{12,1,0},{13,2,12},{15,6,2},{21,7,12},{28,8,2}},{{0,9,2},{9,6,12},{15,6,2},{21,2,12},{23,1,0},{24,4,12},{28,8,2}},{{0,9,2},{9,6,12},{15,6,2},{21,7,12},{28,8,2}},{{0,9,2},{9,6,12},{15,6,2},{21,7,12},{28,8,2}},{{0,10,2},{10,4,12},{14,8,2},{22,5,12},{27,8,2}},{{0,23,2},{23,3,12},{26,8,2}},{{1,32,2}},{{6,24,2}},{{6,9,2},{15,7,0},{22,8,2},{33,2,2}},{{7,8,2},{15,7,0},{22,8,2},{33,2,2}},{{8,8,2},{16,5,0},{21,8,2},{32,3,2}},{{9,20,2},{32,3,2}},{{10,18,2},{30,5,2}},{{11,16,2},{27,1,0},{28,7,2}},{{10,1,2},{11,17,0},{28,7,2}},{{10,2,2},{12,15,0},{27,8,2}},{{10,3,2},{13,13,0},{26,9,2}},{{9,5,2},{14,11,0},{25,10,2}},{{9,6,2},{15,9,0},{24,11,2}},{{9,7,2},{16,6,0},{22,13,2}},{{9,26,2}},{{9,27,2}},{{9,27,2}},{{9,27,2}},{{9,27,2}},{{10,26,2}},{{10,26,2}},{{11,25,2}},{{11,25,2}},{{11,7,2},{20,6,2},{27,9,2}},{{11,7,2},{20,6,2},{28,8,2}},{{11,7,2},{20,6,2},{29,7,2}},{{12,5,2},{20,6,2},{30,5,2}},{{21,4,2}}}
function iflac_drawDog(cx,cy,scale)
	for y=1,#iflac_dog do
		for i=1,#iflac_dog[y] do
			local l=iflac_dog[y][i]
			rect(cx+l[1]*scale,cy+y*scale,l[2]*scale,scale,l[3])
		end
	end
end