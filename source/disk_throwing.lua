
function d84_rotatex(p,angle)
 local xt = p.x
 local yt = p.y*math.cos(angle) - p.z*math.sin(angle)
 local zt = p.y*math.sin(angle) + p.z*math.cos(angle)
 return {x=xt,y=yt,z=zt}
end

function d84_rotatez(p,angle)
 local xt = p.x*math.cos(angle) - p.y*math.sin(angle)
 local yt = p.x*math.sin(angle) + p.y*math.cos(angle)
 local zt = p.z
 return {x=xt,y=yt,z=zt}
end

floppy_sweetie16_invert_pal = "f4f4f45d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff71a1c2c94b0c2566c86333c57"

floppy_front =
{
    {{ x = -37.5, y = -35, z = 0 }, { x = 27.5, y = -35, z = 0 }, { x = 37.5, y = -25, z = 0 }, { x = 37.5, y = 35, z = 0 }, { x = -37.5, y = 35, z = 0 }},
    {{ x = -27.5, y = 35, z = 0 }, { x = -27.5, y = -5, z = 0 }, { x = 27.5, y = -5, z = 0 }, { x = 27.5, y = 35, z = 0 }},
    {{ x = -22.5, y = -35, z = 0 }, { x = -22.5, y = -14, z = 0 }, { x = 22.5, y = -14, z = 0 }, { x = 22.5, y = -35, z = 0 }},
    {{ x = 20.5, y = -33, z = 0 }, { x = 20.5, y = -16, z = 0 }, { x = 10.5, y = -16, z = 0 }, { x = 10.5, y = -33, z = 0 }}
}

floppy_back = 
{
    {{ x = -37.5, y = -35, z = 0 }, { x = 27.5, y = -35, z = 0 }, { x = 37.5, y = -25, z = 0 }, { x = 37.5, y = 35, z = 0 }, { x = -37.5, y = 35, z = 0 }},
    {{ x = -22.5, y = -35, z = 0 }, { x = -22.5, y = -14, z = 0 }, { x = 22.5, y = -14, z = 0 }, { x = 22.5, y = -35, z = 0 }},
    {{ x = 20.5, y = -33, z = 0 }, { x = 20.5, y = -16, z = 0 }, { x = 10.5, y = -16, z = 0 }, { x = 10.5, y = -33, z = 0 }},
    {{ x = 6.015545, y = 7.2215874, z = 0 }, { x = -0.015544, y = 10.7784130, z = 0 }, { x = -6.015544, y = 7.1660106, z = 0 }, { x = -5.984455, y = -0.00321784, z = 0 }, { x = 0.046634, y = -3.56004370, z = 0 }, { x = 6.046634, y = 0.05235897, z = 0 }}
}

floppy_mac=
{
{75,39,92,48,168,48,151,39},
{77,39,94,48,168,48,151,39},
{75,39,92,48,92,136,75,136},
{93,49,168,49,168,122,93,122},
{98,57,99,56,101,55,160,55,162,56,162,57,162,107,161,108,100,108,99,107,98,106},
{92,123,123,123,123,127,92,127},
{158,123,168,123,168,127,158,127},
{101,61,101,102,102,103,103,104,157,104,159,102,159,62,157,60,102,60},
{124,123,157,123,157,127,124,127},
{93,128,93,136,168,136,168,128},
}


function floppy_draw_polylines(polylines,y)
    for _, polyline in ipairs(polylines) do
        for i = 1, #polyline - 2, 2 do
            local x1 = polyline[i]
            local y1 = polyline[i + 1]
            local x2 = polyline[i + 2]
            local y2 = polyline[i + 3]

            line(x1, y+y1, x2, y+y2, 0)  -- Draw line segment in white
        end
        line(polyline[1],y+polyline[2], polyline[#polyline - 1],y+polyline[#polyline], 0)
    end
end

function floppy_mac_face(y)
 y = y or 0
 --mac background
 rect(75,y+40,94,96,12)
 --left eye
 rect(111,y+65,5,5,0)
 rect(111,y+71,5,5,0)
 --right eye
 rect(145,y+65,5,5,0)
 rect(145,y+71,5,5,0)
 --nose
 rect(129,y+65,5,5,0)
 rect(129,y+71,5,5,0)
 rect(129,y+77,5,5,0)
 rect(123,y+77,5,5,0)
 --mouth
 if (time()//1) % 9 == 0  then
  floppy_mouth = ~floppy_mouth
 end
 if floppy_mouth == 0 then
  rect(129,y+95,5,5,0)
  rect(135,y+95,5,5,0)
  rect(123,y+95,5,5,0)
 else
 --open
  rect(129,y+89,5,5,0)
  rect(135,y+89,5,5,0)
  rect(123,y+89,5,5,0)
  rect(129,y+95,5,5,0)
 end
--blackrect
 rect(124,y+123,35,5,0)
 --apple
 circ(98,y+134,2,0)
 circ(102,y+134,2,0)
 circ(105,y+135,2,12)
 line(100,y+130,100,y+131,0)
end

floppy_angle_z = 0
floppy_angle_x = 0
floppy_mouth = 0

function floppy_step_aside(text)
 rect(10,15,math.min(11*text,110),13,12)
 a=string.sub("step aside",0,text)
 print(a,10,15,0,false,2)
end

function floppy_noobs(y)
 rect(132,y+12,99,18,12)
 print("noobs!",132,y+13,0,false,3)
end

function floppy_dots_background(col)
local t=(_t-disk_throwing_st)
 if not col then col = 13 end
 for x_lines =-20,260,15 do
  for y_lines =0,186,3 do
   so=math.sin(y_lines/6)*4
   for o=0,6,3 do
    pix(x_lines+o+so-(t//60)%15,y_lines-(t/60)%38,col)
   end
  end
 end
end

floppy_scene = 0

function floppy_draw_scene_0()
local t=(_t-disk_throwing_st)
 local y=math.max(4-t//600,0)
 floppy_dots_background()
 floppy_mac_face(y)
 floppy_draw_polylines(floppy_mac,y)
 floppy_step_aside(t//100)
 if t > 1500 then
  floppy_noobs(math.min(-25+(t-1500)//10,-2))
 end
end

function floppy_draw_scene_1()
 floppy_dots_background()
 local t=(_t-disk_throwing_st)
 poke4(0x3FF0 * 2 + 1, 12) -- swap colors 2 and 12
 -- draw the sprite
 poke4(2 * 0x3ffc, 4)

 local dt = (t-3000)/20
 dt = math.min(dt,72)
 spr(512,80-dt,20,2,1,0,0,12,14)

 poke4(2 * 0x3ffc, 2)
 poke4(0x3FF0 * 2 + 1, 1) -- swap them back

end

function floppy_draw_scene_2()
 
local t=(_t-disk_throwing_st)
 if t//1%4 == 0 then
  tovram(sweetie16_pal)
 else
  tovram(floppy_sweetie16_invert_pal)
 end
 cls(12)
 floppy_dots_background(0)
 poke4(0x3FF0 * 2 + 1, 12) -- swap colors 2 and 12

 local dt = (t-5000)/200
 poke4(2 * 0x3ffc, 4)
 spr(512+12,70+dt,15,2,1,0,0,12,15)
 poke4(2 * 0x3ffc, 2)
 poke4(0x3FF0 * 2 + 1, 1) -- swap them back

end

function floppy_draw_scene_3()
 tovram(sweetie16_pal)
 local t=(_t-disk_throwing_st)/50-200
 local ox=0
 local oy=0
 local floppy = nil
 --between 90 and 270 in radians
 if floppy_angle_x > 1.57 and floppy_angle_x < 6.28-1.57 then
  floppy = floppy_back
 else
  floppy = floppy_front
 end
 
 for poly =1,#floppy do
  for x=1, #floppy[poly]-1 do
   p1 = floppy[poly][x]
   p2 = floppy[poly][x+1]
   p1 = d84_rotatez(p1,floppy_angle_z)
   p1 = d84_rotatex(p1,-floppy_angle_x)
   p2 = d84_rotatez(p2,floppy_angle_z)
   p2 = d84_rotatex(p2,-floppy_angle_x)
   p1.x = p1.x*1.2 + t
   p2.x = p2.x*1.2 + t
   p1.y = p1.y*1.2
   p2.y = p2.y*1.2
   p1.z = p1.z*1.2 + 800
   p2.z = p2.z*1.2 + 800
   p1 = d84_project(p1)
   p2 = d84_project(p2)
   line(
    ox+p1.x,
    oy+p1.y,
    ox+p2.x,
    oy+p2.y,
				0
   )
  end
  p1 = floppy[poly][#floppy[poly]]
  p2 = floppy[poly][1]
  p1 = d84_rotatez(p1,floppy_angle_z)
  p1 = d84_rotatex(p1,-floppy_angle_x)
  p2 = d84_rotatez(p2,floppy_angle_z)
  p2 = d84_rotatex(p2,-floppy_angle_x)
  p1.x = p1.x*1.2+t
  p2.x = p2.x*1.2+t
  p1.y = p1.y*1.2
  p2.y = p2.y*1.2
  p1.z = p1.z*1.2 + 800
  p2.z = p2.z*1.2 + 800
  p1 = d84_project(p1)
  p2 = d84_project(p2)
  line(ox+p1.x,oy+p1.y,ox+p2.x,oy+p2.y,0)
 end
 
 local screen_width = 240 
 local screen_height = 136 
 local num_lines = 5 
 
 for i = 1, num_lines do
  local start_x = math.random(screen_width)
  local start_y = math.random(screen_height)
  local end_x = start_x + math.random(50, 100)
  local end_y = start_y
  local color = 0 

  line(start_x, start_y, end_x, end_y, color)
 end
 
 floppy_angle_z=floppy_angle_z+0.04
 floppy_angle_x=floppy_angle_x+0.02
 if floppy_angle_z > 6.28 then
  floppy_angle_z = floppy_angle_z - 6.28
 end
 if floppy_angle_x > 6.28 then
  floppy_angle_x = floppy_angle_x - 6.28
 end
end


disk_throwing_st = 0
function disk_throwing_init()
	disk_throwing_st=_t
	floppy_scene = 0
	sweetie16_init()
	salad(1,{pineapple,apple,passionfruit},4000,2000)
	salad(2,{apple,fig},2400,2000)
	salad(4,{apple,pear},5200,2000)
end

function disk_throwing()
 cls(12)
 local t=(_t-disk_throwing_st)
 if t < 2000 then
  floppy_scene = 0 --step aside
 elseif t < 3000 then
  floppy_scene = 1 --charging
 elseif t < 4000 then
  floppy_scene = 2 --shooting
 else
  floppy_scene = 3 --disc
 end
 
 if floppy_scene == 0 then
  floppy_draw_scene_0()
 elseif floppy_scene == 1 then
  floppy_draw_scene_1()
 elseif floppy_scene == 2 then
  floppy_draw_scene_2()
 elseif floppy_scene == 3 then
  floppy_draw_scene_3()
 end

 overlay_defaults((_t-disk_throwing_st),"09","VOOD")
end
