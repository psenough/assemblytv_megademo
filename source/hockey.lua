local text={
{c='s',b={{0,1,1,1,1,0},
						    {1,0,0,0,0,0},
						    {0,1,1,1,0,0},
						    {0,0,0,0,1,0},
						    {1,1,1,1,0,0}}},
{c='w',b={{1,0,0,0,1,0},
						    {1,0,1,0,1,0},
						    {1,0,1,0,1,0},
						    {1,0,1,0,1,0},
						    {0,1,1,1,0,0}}},
{c='e',b={{0,1,1,1,1,0},
						    {1,0,0,0,0,0},
						    {1,1,1,1,1,0},
						    {1,0,0,0,0,0},
						    {0,1,1,1,1,0}}},
{c=' ',b={{0,0,0,0,0,0},
						    {0,0,0,0,0,0},
						    {0,0,0,0,0,0},
						    {0,0,0,0,0,0},
						    {0,0,0,0,0,0}}},
{c='f',b={{0,1,1,1,1,0},
						    {1,0,0,0,0,0},
						    {1,1,1,1,1,0},
						    {1,0,0,0,0,0},
						    {1,0,0,0,0,0}}},
{c='i',b={{0,1,1,1,0,0},
						    {0,0,1,0,0,0},
						    {0,0,1,0,0,0},
						    {0,0,1,0,0,0},
						    {0,1,1,1,0,0}}},
{c='n',b={{1,0,0,0,1,0},
						    {1,1,0,0,1,0},
						    {1,0,1,0,1,0},
						    {1,0,0,1,1,0},
						    {1,0,0,0,1,0}}},
{c='3',b={{1,1,1,1,0,0},
						    {0,0,0,0,1,0},
						    {1,1,1,1,0,0},
						    {0,0,0,0,1,0},
						    {1,1,1,1,0,0}}},
{c='7',b={{1,1,1,1,1,0},
						    {0,0,0,1,0,0},
						    {0,0,1,0,0,0},
						    {0,1,0,0,0,0},
						    {1,0,0,0,0,0}}},
{c='-',b={{0,0,0,0,0,0},
						    {0,0,0,0,0,0},
						    {1,1,1,1,1,0},
						    {0,0,0,0,0,0},
						    {0,0,0,0,0,0}}},
						}


local floor=math.floor
local timepass = 0

function hoc_palette()
 poke(0x3FCF,0xff)
 poke(0x3FD0,0xcc)
 poke(0x3FD1,0xaa)
 poke(0x3FD2,0xab)
 poke(0x3FD3,0x52)
 poke(0x3FD4,0x36)
end

function hoc_plrceleb(t_shf)
 local SuuleHP={43,110,81,127,41,127,8,43,110,81,127,77,114,8,79,115,81,82,42,94,12,79,115,57,111,42,94,12,57,111,42,94,43,110,12,42,94,42,81,81,82,12,42,81,38,72,81,82,12,86,70,38,72,81,82,12,86,70,83,52,43,54,12,86,70,38,72,43,54,12,43,54,29,63,38,72,12,43,54,29,63,35,47,12,43,54,29,63,35,47,12,25,57,29,63,35,47,12,25,57,20,46,35,47,12,31,39,20,46,35,47,12,31,39,20,46,35,47,12,31,39,25,44,29,37,12,83,52,86,70,91,64,12,83,52,97,54,91,64,12,83,52,97,54,88,45,12,101,37,97,54,88,45,12,101,37,90,34,88,45,12,42,86,42,94,50,95,13,37,117,42,110,42,99,13,53,107,42,110,42,99,13,57,105,76,103,77,98,13,57,111,76,103,79,115,13,42,81,47,61,38,72,13,75,91,79,91,77,97,13,75,91,76,83,60,93,13,75,91,76,83,79,91,13,81,82,76,83,79,91,13,83,52,71,63,76,52,13,74,56,61,62,76,52,13,42,53,61,62,62,55,13,47,55,51,61,55,59,13,29,63,34,57,38,72,13,27,54,25,57,20,46,13,27,54,25,43,20,46,13,32,49,35,47,31,39,13,77,75,75,68,81,64,13,81,64,91,64,86,70,13,81,64,91,64,89,60,13,94,49,88,45,90,34,13,76,52,49,54,61,62,14,42,115,43,109,37,117,14,81,82,76,103,79,115,14,77,75,86,70,81,64,14,25,44,16,42,20,46,14,25,44,16,42,29,37,14,101,37,90,34,102,31,14,101,37,90,34,97,39,14,61,77,48,82,44,74,10,61,77,48,82,61,84,10,61,77,61,84,76,83,10,61,77,77,75,76,83,10,27,54,42,53,32,49,10,27,54,42,53,34,57,10,83,52,97,54,89,60,10,83,52,97,54,94,49,10,42,81,44,74,38,72,9,42,81,44,74,48,82,9,77,75,81,82,76,83,9,77,75,81,82,86,70,8,25,57,34,57,27,54,9,25,57,34,57,29,63,9,32,49,42,53,35,47,9,91,64,97,54,89,60,9,83,52,88,45,94,49,9,28,117,16,14,20,13,15,28,117,16,14,24,118,15,20,9,16,14,20,13,15,20,9,16,14,8,9,15,20,9,8,9,14,3,4,4,0,8,9,14,3,4,4,0,8,9,0,2,4,0,7,8,9,0,2,4,19,35,16,42,19,41,12,19,35,16,42,14,37,12,19,35,14,32,14,37,12,19,35,14,32,17,28,12,19,35,21,28,17,28,12,25,35,20,38,19,35,12,25,35,22,31,19,35,12,25,35,22,31,26,30,12,25,35,29,35,26,30,12,25,35,29,35,26,40,12,21,32,21,28,26,30,13,25,35,22,37,22,41,13,25,35,26,40,22,41,13,100,35,104,19,104,26,12,100,35,104,19,101,16,12,100,35,95,27,101,16,12,100,35,95,27,95,35,12,92,31,95,27,95,35,12,92,31,95,27,93,26,12,92,31,90,28,93,26,12,90,21,90,28,93,26,12,90,21,93,19,93,26,12,90,34,90,28,92,31,13,90,34,92,31,95,35,13,101,16,95,24,95,27,13,102,31,100,29,104,26,13,102,31,100,29,100,35,13,95,35,100,29,100,35,13,64,48,66,57,70,50,6,64,48,70,41,70,50,6,64,48,51,46,51,38,6,64,48,66,55,63,58,5,64,48,59,59,63,58,5,64,48,59,59,56,58,5,64,48,55,56,56,58,5,64,48,55,56,51,53,5,64,48,51,53,50,46,5,64,48,59,45,50,46,5,54,34,50,44,62,34,10,54,34,50,44,59,43,10,54,34,65,34,59,43,10,67,39,65,34,59,43,10,67,39,67,43,59,43,10,63,47,67,43,59,43,10,71,40,64,34,67,39,9,71,40,67,43,67,39,9,71,40,67,43,68,46,9,71,40,70,51,68,46,9,71,40,70,51,71,48,9,66,47,68,45,67,43,9,66,47,63,47,67,43,9,66,47,63,47,63,50,9,66,47,65,50,63,50,9,54,34,50,45,48,43,9,54,34,48,43,48,40,9,54,34,54,35,62,34,9,50,49,50,45,48,43,8,}
 local len=print("SWE 3:7 FIN",240,0,3,false,4)
 local tx_1=61
 local ty_1=30-(6*mSin(mPi*t_shf/16)+8)
 local ty_2=76-(3*mCos(mPi*t_shf/16))
 print("SWE 3:7 FIN",121-len/2,41,((t_shf/4)+1)%16+1,false,4)   
 print("SWE 3:7 FIN",120-len/2,40,(t_shf/4)%16+1,false,4) 
	for vert_i=1,#SuuleHP,7 do
	 tri(SuuleHP[vert_i]/2+tx_1/2,SuuleHP[vert_i+1]/2+ty_2,SuuleHP[vert_i+2]/2+tx_1/2,SuuleHP[vert_i+3]/2+ty_2,SuuleHP[vert_i+4]/2+tx_1/2,SuuleHP[vert_i+5]/2+ty_2,SuuleHP[vert_i+6])
	 tri(-SuuleHP[vert_i]/2+tx_1*3.5,SuuleHP[vert_i+1]/2+ty_2,-SuuleHP[vert_i+2]/2+tx_1*3.5,SuuleHP[vert_i+3]/2+ty_2,-SuuleHP[vert_i+4]/2+tx_1*3.5,SuuleHP[vert_i+5]/2+ty_2,SuuleHP[vert_i+6])
	end
	for vert_i=1,#SuuleHP,7 do
	 tri(SuuleHP[vert_i]+tx_1,SuuleHP[vert_i+1]+ty_1,SuuleHP[vert_i+2]+tx_1,SuuleHP[vert_i+3]+ty_1,SuuleHP[vert_i+4]+tx_1,SuuleHP[vert_i+5]+ty_1,SuuleHP[vert_i+6])
	end
end	

function hoc_audceleb(t_shf)
 local pers_x = 1
 local pers_y = 1
 local tx_1=1.5*mSin(mPi*t_shf/8)
 local tx_2=1.5*mCos(mPi*t_shf/8) 
 local ty_1=1.5*mSin(mPi*t_shf/8)
 local ty_2=1.5*mCos(mPi*t_shf/8)
 local hair={6,6,3,6, 2,14,3,3, 2,1,13,5, 4,6,12,5, 
             3,14,6,6, 13,2,3,6, 6,4,4,6, 12,6,3,6}

 for aud_y=0,5 do
  for aud_i=1,64 do 
   row1_shf=mSin(mPi*aud_i/2)+mSin(mPi*(aud_i+2)/(6+aud_y))
   rect(aud_i*8-43+aud_y*4,82+(6*aud_y)+row1_shf+ty_1-ty_2,7,15,15-aud_y)          
   circ(aud_i*8-40+aud_y*4,78+(6*aud_y)+row1_shf+ty_1-ty_2,2,hair[(aud_i+aud_y*3)%32])  
   if aud_i%6 == 1 then
    circ(aud_i*8-40+aud_y*4,79+(6*aud_y)+row1_shf+ty_1-ty_2,3,hair[(aud_i+aud_y*3)%32])  
   end 
   if aud_i%7 == 1 then
    elli(aud_i*8-40+aud_y*4,79+(6*aud_y)+row1_shf+ty_1-ty_2,3,4,hair[(aud_i+aud_y*3)%32])  
   end 
   circ(aud_i*8-40+aud_y*4,80+(6*aud_y)+row1_shf+ty_1-ty_2,2,5)
  end 
 end 
 -- Ice Rink
 line(-380,98,620,98,12)
 for aud_i=0,7 do
  rect(-20+aud_i*40,96,2,25,1)
 end
 rect(-380,117,1000,14,2)
 rect(-380,127,1000,10,13) 
 rect(-380,133,1000,10,12)  
end

function hoc_shot(t_shot)
 local SuuleHS={215,117, 210,87, 239,115, 239,86,
                173,130, 161,93, 239,123, 239,86,
                134,77,  130,48, 239,83,  239,56,
                104,39,  98,1,   239,49,   239,8}
 hoc_palette()
 cls()
 -- rink
 ellib(77,150,198,112,12)   
 rect(36,40,4,120,1)  
-- rect(120,40,4,120,1)   
 rect(180,54,3,120,1)    
-- rect(210,66,2,120,1)     
 rect(225,76,2,120,1)      
-- rect(235,83,2,120,1)       
 elli(77,120,168,31,2) 
 if t_shot > 10 then
  spr(97,240-2*(t_shot-10), 80-1/16*(t_shot-10), 0, 3, 0, 0, 2, 2)
  spr(97,-64+3*(t_shot-10), 56-1/32*(t_shot-10), 0, 4, 1, 0, 2, 2) 
 end
  -- puck
 if (t_shot > 26) and (t_shot < 32) then
  local tri_i=(t_shot-27)*6
  tri(SuuleHS[tri_i+1],SuuleHS[tri_i+2],SuuleHS[tri_i+3],SuuleHS[tri_i+4],SuuleHS[tri_i+5],SuuleHS[tri_i+6],4)
  tri(SuuleHS[tri_i+7],SuuleHS[tri_i+8],SuuleHS[tri_i+3],SuuleHS[tri_i+4],SuuleHS[tri_i+5],SuuleHS[tri_i+6],4)  
 end
 if t_shot > 30 then
  elli(149-(t_shot-30)*48,106-(t_shot-30)*3,48,6,15) 
  rect(101-(t_shot-30)*48,106-(t_shot-30)*3,97,24,15)
 else
  elli(149,106,48,6,15) 
  rect(101,106,97,24,15)
 end 
 -- ice
 elli(77,148,218,33,12)
end

function hoc_puck()
 elli(120,70,5,3,15)
 elli(120,69,5,3,15)
 elli(120,68,5,3,14) 
 ellib(120,68,4,2,15)  
end

function hoc_speedlines(t_shf)
 local spdlns = {  264, 204, 274, 207,
 				   317, 196, 323, 199,
                   407, 194, 413, 197,
                   370, 143, 376, 146,
                   254,  16, 260,  19,
                   135, 173, 141, 176,
                   301,  72, 307,  75,
                   111, 179, 117, 182,
                   274, 228, 280, 231,
                   257,  93, 263,  96} 
                    
 t_bstx=(t_shf*12)%200
 t_bsty=((t_shf*12)%400)/2 
 for i_spd = 0,9 do 
  line(spdlns[i_spd*4+1]-t_bstx,
       spdlns[i_spd*4+2]-t_bsty,
       spdlns[i_spd*4+3]-t_bstx,
       spdlns[i_spd*4+4]-t_bsty,10)
 end 
end

function hoc_field(t_shf)
 ellib(80-(t_shf*12), 280-(t_shf*12)/2,280,140,2)
 line(0-(t_shf*12),   966-(t_shf*12)/2,
      1999-(t_shf*12), -33-(t_shf*12)/2,2)
 spr(97,340-(t_shf*12), 80-(t_shf*12)/2, 0, 8, 0, 0, 2, 2)      
 spr(97,0-(t_shf*12), 80-(t_shf*12)/2, 0, 8, 1, 0, 2, 2)       
 spr(97,908-(t_shf*12), 344-(t_shf*12)/2, 0, 8, 0, 0, 2, 2)        
end

function hoc_goaldraw(t_shf)
 local SuuleGL={ 139, 116, 139, 123, 91,   99,
                 139, 116,  96,  96, 91,   99,
                 139, 116, 139, 123, 252,  66,
                 139, 116, 239,  66, 252,  66,
                 91,  99,   96,  96,  96,  40,
                 91,  37,   91,  99,  96,  40,
                 91,  37,   207,-16, 197, -16,
                 91,  37,   207,-16,  96,  40,
                 239,  66, 252,  66, 202,  47,
                 207,  45, 252,  66, 202,  47,
                 239,  66, 252,  66, 202,  47,
                 207,  45, 202, -16, 202,  47,                 
                 207, -16, 202, -16, 207,  45,
                 }
  corrx=828-t_shf*12               
  corry=414-(t_shf*12)/2
  for tri_i=0,12 do
   tri(SuuleGL[(tri_i*6)+1]+corrx,SuuleGL[(tri_i*6)+2]+corry,SuuleGL[(tri_i*6)+3]+corrx,SuuleGL[(tri_i*6)+4]+corry,SuuleGL[(tri_i*6)+5]+corrx,SuuleGL[(tri_i*6)+6]+corry,2)
  end
  line(93+corrx,39+corry,137+corrx,61+corry,13)
  line(139+corrx,120+corry,137+corrx,61+corry,13)  
  line(137+corrx,61+corry,249+corrx,7+corry,13)    
  line(249+corrx,63+corry,246+corrx,7+corry,13)      
end

function hoc_goal(t_goal)
 cls(12)
 if t_goal < 73 then 
  hoc_field(t_goal)
  hoc_puck()
  hoc_goaldraw(t_goal)
  hoc_speedlines(t_goal)  
 else 
  hoc_puck()
  hoc_field(73)
  hoc_goaldraw(73)
 end 

 --trace(t_goal)
end 

function hoc_board(t_board)
 local strin="swe 3 7 fin"--e 3 7 fin"
 local strina={1,2,3,4,8,10,9,4,5,6,7,4,4,4}

-- draw from cx/cy
 cx = 116 + 2*mSin(t_board/70) -- OG: 70
 cy = 56 + 2*mSin(t_board/100) -- OG: 100

-- make new array of 5x50 from 
--  strin and text
 screen={}
 startline=20-floor(t_board/2)
 for board_i=1,50 do
  screen[board_i] = {0,0,0,0,0}
  cursor = board_i-startline
  if cursor > 0 then
   char = floor(cursor/6)
   bb=text[strina[(char)%#strina+1]].b
   for board_j=1,5 do
    screen[board_i][board_j]=bb[board_j][cursor%6+1]
   end
  end
 end
-- draw background
 cls()
 x1=cx-110
 x2=cx
 x3=cx+120
 x4=cx+15
 y1=cy-5
 y2=cy-35
 y3=cy+5
 y4=cy+25
 y5=cy+35
 y6=cy+40
 y7=cy+55
 y8=cy+65
 y9=cy+70
 h1=30
 h2=35
 h3=25

--topleft
 tri(x1,y1,x1,y7,x2,y2,15)
 tri(x1,y7,x2,y6,x2,y2,15)

--topright
 tri(x3,y3,x3,y8,x2,y2,15)
 tri(x3,y8,x2,y6,x2,y2,15)

-- bottom
 tri(x1,y7,x2,y6,x4,y9,0)
 tri(x3,y8,x2,y6,x4,y9,0)

--sides
 line(x1,y1,x2,y2,12)
 line(x3,y3,x2,y2,12)
 line(x1,y4,x2,cy,12)
 line(x3,y5,x2,cy,12)

--bottom
 line(x1,y7,x2,y6,12)
 line(x3,y8,x2,y6,12)
 line(x1,y7,x4,y9,12)
 line(x3,y8,x4,y9,12)

--edges
 line(x1-1,y1,x1-1,y7,12)
 line(x2,y2,x2,y6,12)
 line(x3+1,y3,x3+1,y8,12)

--cables
 line((x2+x1)/2,(y2+y1)/2,(x2+x1)/2,0,12)
 line((x2+x3)/2,(y2+y3)/2,(x2+x3)/2,0,12)

-- draw text
--  array divided by cx
 for board_i=1,20 do
  ix=(board_i-1)/20 * (x2-x1)+x1
  iy=(board_i-1)/20 * (y2-y1)+y1
  dy=(board_i-1)/20 * (h2-h1)/5+5
  for board_j=1,5 do
   col=0
   if screen[board_i][board_j] then col = screen[board_i][board_j]*5 end
   elli(ix+2,iy+(board_j)*dy,2,3,col)
  end
 end
 for board_i=1,20 do
  ix=board_i/20 * (x3-x2)+x2
  iy=board_i/20 * (y3-y2)+y2
  dy=(20-board_i)/20 * mAbs(h3-h2)/7 +5
  for board_j=1,5 do
   col=0
   if screen[20+board_i][board_j] then col = screen[20+board_i][board_j]*5 end
   elli(ix-2,iy+(board_j)*dy -2,2,3,col)
  end
 end
end 

function hoc_celeb(t_celeb)
 cls()
 hoc_palette()
 hoc_audceleb(t_celeb)
 hoc_plrceleb(t_celeb)
end

hockey_st = 0
function hockey_init()
	timepass=0
	hockey_st = _t
	sweetie16_init()
	salad(1,{banana,watermelon},3000,1000)
	salad(2,{pear,kiwi},2200,2000)
	salad(2,{blueberry,papaya,fig},5200,2000)
	salad(4,{peach,pineapple,cherry},1000,2000)
end

function hockey()
 timepass=timepass+1 

 local goal=141
 local board=281
 local celeb=581

 if (timepass >= 0) and (timepass < goal) then
  hoc_shot(timepass) 
 end
 if (timepass >= goal) and (timepass < board) then
  hoc_goal(timepass-goal)
 end
 if (timepass >= board) and (timepass < celeb) then 
  hoc_board(timepass-board)
 end
 if (timepass >= celeb) then 
  hoc_celeb(timepass)
 end

 overlay_defaults((_t - hockey_st), "37", "HOCK")
end



