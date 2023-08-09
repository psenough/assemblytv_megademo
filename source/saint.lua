local saint_t=0

local saint_part=1
local saint_horns=0
local saint_horncount=0

local saint_flash=0
local saint_flashcount=0
local saint_lines={}

local saint_pal="1a1c2cd62c76b13e53ef7d57ffcd75a7f07038b7642571796379dc6a81cb91c8f373eff7f4f4f4daf1ffcddae8333c57"

function d84_project(p)
	local x = p.x / p.z
	local y = p.y / p.z
	local r = math.sqrt(x*x + y*y)
	local theta = math.atan(r)
	local theta_d = theta * (1 + 4 * theta * theta)
	local distortionFactor = theta_d / math.max(r,0.00001) * 600
	x = distortionFactor * x
	y = distortionFactor * y

	return {x=120+x,y=68+y,z=p.z}
end

function d84_split_into_lines(lines,x1, y1, z1, x2, y2, z2, step, color)
	local t_step = 1 / step
	local x_prev, y_prev, z_prev = x1, y1, z1

	for t = t_step, 1, t_step do
	local x = x1 + (x2 - x1) * t
	local y = y1 + (y2 - y1) * t
	local z = z1 + (z2 - z1) * t
	table.insert(lines, {{x=x_prev,y= y_prev,z= z_prev}, {x=x,y= y,z= z}, color})
	x_prev, y_prev, z_prev = x, y, z
	end

	if #lines < step then
	table.insert(lines, {{x=x_prev, y=y_prev, z=z_prev}, {x=x2, y=y2, z=z2}})
	end

end

function d84_populate_grids(topX, topY, bottomX, bottomY, steps)
	local lines={}
	local stepX = (bottomX - topX) / steps
	local stepY = (bottomY - topY) / steps

	for i = 0, steps do
		local x = topX + stepX * i
		local y = topY + stepY * i
		color = 13
		if i == 0 or i == steps then
			color = 12
		end

		d84_split_into_lines(lines,x,topY,bottomY,x,bottomY,bottomY,steps,color)
		d84_split_into_lines(lines,x,bottomY,topY,x,bottomY,bottomY,steps,color)
		d84_split_into_lines(lines,bottomY,topY,x,bottomY,bottomY,x,steps,color)

		d84_split_into_lines(lines,topX,y,bottomY,bottomX,y,bottomY,steps,color)
		d84_split_into_lines(lines,topX,bottomY,y,bottomX,bottomY,y,steps,color)
		d84_split_into_lines(lines,bottomX,y,topX,bottomY,y,bottomX,steps,color)
	end

	return lines
end

function d84_generate_sphere(centerX, centerY, centerZ, radius, resolution)
	local triangles = {}

	for i = 0, resolution - 1 do
		for j = 0, resolution - 1 do
			-- Convert spherical coordinates to Cartesian
			local theta1 = 2 * math.pi * i / resolution
			local theta2 = 2 * math.pi * ((i+1) % resolution) / resolution
			local phi1 = math.pi * (j / resolution - 0.5)
			local phi2 = math.pi * ((j+1) / resolution - 0.5)

			local x1 = centerX + radius * math.cos(phi1) * math.cos(theta1)
			local y1 = centerY + radius * math.cos(phi1) * math.sin(theta1)
			local z1 = centerZ + radius * math.sin(phi1)

			local x2 = centerX + radius * math.cos(phi2) * math.cos(theta1)
			local y2 = centerY + radius * math.cos(phi2) * math.sin(theta1)
			local z2 = centerZ + radius * math.sin(phi2)

			local x3 = centerX + radius * math.cos(phi2) * math.cos(theta2)
			local y3 = centerY + radius * math.cos(phi2) * math.sin(theta2)
			local z3 = centerZ + radius * math.sin(phi2)

			-- Insert first triangle
			table.insert(triangles, {{x=x1, y=y1, z=z1}, {x=x2, y=y2, z=z2}, {x=x3, y=y3, z=z3}})

			local x4 = centerX + radius * math.cos(phi1) * math.cos(theta2)
			local y4 = centerY + radius * math.cos(phi1) * math.sin(theta2)
			local z4 = centerZ + radius * math.sin(phi1)

			-- Insert second triangle
			table.insert(triangles, {{x=x1, y=y1, z=z1}, {x=x3, y=y3, z=z3}, {x=x4, y=y4, z=z4}})
		end
	end

	return triangles
end

local saint_st = 0
function saint_init()
	saint_st=_t

	saint_part=1
	saint_horns=0
	saint_horncount=0

	saint_flash=0
	saint_flashcount=0

	saint_t = 0
	saint_lines = d84_populate_grids(-165,-165,165,165,12)
	saint_triangles = d84_generate_sphere(0,40,0,60,10)

	sweetie16_init()

	salad(1,{grapes,pear},4000,2000)
	salad(2,{orange,kiwi,passionfruit,fig},3000,1000)
	salad(3,{fig,kiwi,pineapple,apple},2200,1000)
	salad(4,{pineapple,cherry,mango,fig,strawberry},2000,3000)
end


function saint()

	local saint_t = (_t-saint_st)/1000

	if saint_t < 3 then
		saint_part = 1
	elseif saint_t < 6.28 then --12
		saint_part = 2
	elseif saint_t < 12.56 then --18.84
		saint_part = 3
	elseif saint_t < 18.84 then --25.14
		saint_part = 4
		local detail = 22.84-saint_t
		if detail < 4.0 then
		detail = 4.0
		end
		saint_triangles = d84_generate_sphere(0,40,0,60,detail)
	elseif saint_t < 23 then
		saint_part = 5
	elseif saint_t > 28.84 then
		--saint_end()
	end

	cls(0)

	local m_s_t = math.sin(saint_t)
	local m_c_t = math.cos(saint_t)

	local sy=math.sin(0.8+m_s_t/4)
	local cy=math.cos(0.8+m_s_t/4)
	local sx=math.sin(0.2+m_s_t/8)
	local cx=math.cos(0.2+m_s_t/8)
	local sz=math.sin(m_c_t/5)
	local cz=math.cos(m_c_t/5)

	local z=880-m_s_t*100

	for x=1,#saint_lines do
		local p1 = saint_lines[x][1]
		local p2 = saint_lines[x][2]

		-- rotate p1
		local p1x,p1y,p1z=p1.x,p1.y,p1.z
		p1x,p1z=cy*p1x-sy*p1z,cy*p1z+sy*p1x
		p1y,p1z=cx*p1y-sx*p1z,cx*p1z+sx*p1y
		p1x,p1y=cz*p1x-sz*p1y,cz*p1y+sz*p1x
		-- rotate p2
		local p2x,p2y,p2z=p2.x,p2.y,p2.z
		p2x,p2z=cy*p2x-sy*p2z,cy*p2z+sy*p2x
		p2y,p2z=cx*p2y-sx*p2z,cx*p2z+sx*p2y
		p2x,p2y=cz*p2x-sz*p2y,cz*p2y+sz*p2x

		p1=d84_project({x=p1x,y=p1y-50,z=p1z+z})
		p2=d84_project({x=p2x,y=p2y-50,z=p2z+z})

		line(p1.x,p1.y,p2.x,p2.y,saint_lines[x][3])
	end

	sy=math.sin(0.5+saint_t)
	cy=math.cos(0.5+saint_t)
	sx=math.sin(-0.8+saint_t)
	cx=math.cos(-0.8+saint_t)
	sz=math.sin(-0.2+saint_t)
	cz=math.cos(-0.2+saint_t)

	local o=m_s_t*10
	local scale
	if saint_part == 1 then
		scale=0.05
	elseif saint_part == 2 then
		scale=1.5
	elseif saint_part <= 4 then
		scale=1.5+m_s_t/2
	elseif saint_part == 5 then
		scale=(1.5+m_s_t/2)*(28.84-saint_t)/10
	end

	for i=1,#saint_triangles do
		local p1 = saint_triangles[i][1]
		local p2 = saint_triangles[i][2]
		local p3 = saint_triangles[i][3]

		local p1x,p1y,p1z=p1.x*scale,(p1.y+o)*scale,(p1.z+o)*scale
		local p2x,p2y,p2z=p2.x*scale,(p2.y+o)*scale,(p2.z+o)*scale
		local p3x,p3y,p3z=p3.x*scale,(p3.y+o)*scale,(p3.z+o)*scale

		-- rotate p1
		p1x,p1z=cy*p1x-sy*p1z,cy*p1z+sy*p1x
		p1y,p1z=cx*p1y-sx*p1z,cx*p1z+sx*p1y
		p1x,p1y=cz*p1x-sz*p1y,cz*p1y+sz*p1x
		-- rotate p2
		p2x,p2z=cy*p2x-sy*p2z,cy*p2z+sy*p2x
		p2y,p2z=cx*p2y-sx*p2z,cx*p2z+sx*p2y
		p2x,p2y=cz*p2x-sz*p2y,cz*p2y+sz*p2x
		-- rotate p3
		p3x,p3z=cy*p3x-sy*p3z,cy*p3z+sy*p3x
		p3y,p3z=cx*p3y-sx*p3z,cx*p3z+sx*p3y
		p3x,p3y=cz*p3x-sz*p3y,cz*p3y+sz*p3x

		if saint_part > 1 then
			p1y=p1y-30
			p2y=p2y-30
			p3y=p3y-30
		end

		p1=d84_project({x=p1x+50,y=p1y,z=p1z+1000})
		p2=d84_project({x=p2x+50,y=p2y,z=p2z+1000})
		p3=d84_project({x=p3x+50,y=p3y,z=p3z+1000})

		if i%2==0 then
			ttri(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,0,8,8,8,8,16,0,-1,p1.z,p2.z,p3.z)
		else
			ttri(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,0,8,0,16,8,16,0,-1,p1.z,p2.z,p3.z)
		end
	end

	if saint_part > 1 then
		if saint_horncount % 15 == 0 then
		saint_horns = not saint_horns
	end

	if saint_flashcount % 12  == 0 or saint_flashcount % 21 == 0 then
		saint_flash = not saint_flash
	end

	if saint_flash then
		tovram(saint_pal)
	else
		tovram(sweetie16_pal)
	end

	end

	if saint_horns then
		spr(282,0,20,0,1,0,0,6,8)
		spr(426,48,28,0,1,0,0,6,6)
	else
		spr(272,0,20,0,1,0,0,9,8)
	end

	spr(384,0,75,0,1,0,0,9,9)
	--saint_t=saint_t+0.02
	saint_horncount=saint_horncount+1
	saint_flashcount=saint_flashcount+1

	overlay_defaults((_t-saint_st),"97","JORM")
end
