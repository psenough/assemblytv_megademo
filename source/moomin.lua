
local Ma = -22
local Mframe = 0
--local timepass = 0
--local pi = math.pi
local cos = math.cos
local sin = math.sin
local abs = math.abs
local flr = math.floor
local ron = math.round

function setcolour(col, red, green, blue)
  poke(0x3FC0+col*3, red)
  poke(0x3FC1+col*3, green)
  poke(0x3FC2+col*3, blue)    
end

function background(timepass)
 local ix = 0
 local sx = 0
 local _1wav = 0
 local _2wav = 0 
 local _3wav = 0
 cls(1)
 for ix=0,239 do
 -- Mountains
  _1wav=3*cos(((ix-timepass)/6.1)/4*mPi)
  _2wav=3*cos(((ix-timepass)/4.7)/4*mPi)
  _3wav=3*cos(((ix-timepass)/8.4)/4*mPi)
  line(ix,30+_1wav+_2wav+_3wav,ix,100,7)
 -- Forests 
  _1wav=cos(((50+ix-timepass)/1.5)/2*mPi)+3*cos(((50+ix-timepass)/24)/2*mPi)
  _2wav=cos((50+ix-timepass)/2*mPi)+3*cos(((50+ix-timepass)/12)/2*mPi)
  _3wav=cos(((50+ix-timepass)/2.5)/2*mPi)
  line(ix,50+_1wav+_2wav+_3wav,ix,100,6)  
 -- Hill + gradients
  _1wav=sin(((70+ix-timepass)/16)/2*mPi)
  _2wav=sin(((70+ix-timepass)/12)/2*mPi)
  _3wav=sin(((70+ix-timepass)/20)/2*mPi)
 -- This dither code is a bit dirty, it does its job, 
 -- any idea to improve it?  
  for sx=70,90 do
   if sx > 70+_1wav+_2wav+_3wav then
    if sx%2 == 1 then 
     pix(ix,sx, 5+abs(sx%2-ix%2))
    else
     pix(ix,sx, 6)
    end 
   end
  end  
  _1wav=sin(((80+ix-timepass)/16)/2*mPi)
  _2wav=sin(((40+ix-timepass)/12)/2*mPi)
  _3wav=sin(((20+ix-timepass)/20)/2*mPi)
  for sx=80,95 do
   if sx > 80+_1wav+_2wav+_3wav then
    pix(ix,sx, 5+abs(sx%2-ix%2))
   end
  end  
  _1wav=sin(((35+ix-timepass)/16)/2*mPi)
  _2wav=sin(((120+ix-timepass)/12)/2*mPi)
  _3wav=sin(((78+ix-timepass)/20)/2*mPi)
  for sx=90,100 do
   if sx > 90+_1wav+_2wav+_3wav then
    if sx%2 == 1 then 
     pix(ix,sx, 5+abs(sx%2-ix%2))
    else
     pix(ix,sx, 5)
    end 
   end
  end  
  _1wav=sin(((56+ix-timepass)/16)/2*mPi)
  _2wav=sin(((110+ix-timepass)/12)/2*mPi)
  _3wav=sin(((33+ix-timepass)/20)/2*mPi)
  line(ix,99+_1wav+_2wav+_3wav,ix,119,5)    
 -- Road
  _1wav=0.5*sin(((20+ix-timepass)/24)/2*mPi)
  _2wav=0.5*sin(((70+ix-timepass)/8)/2*mPi)
  _3wav=0.5*sin(((50+ix-timepass)/16)/2*mPi)  
  line(ix,110+_1wav+_2wav,ix,116+_3wav+_2wav,4)  
 end
 line( 95, 113, 225, 113, 3)
 line(100, 114, 210, 114, 3) 
 line( 35, 113, 48, 113, 3) 
end

function foreground(timepass)
 local _1wav = 0
 local _2wav = 0 
 local _3wav = 0
 local tbase1 = timepass%500
 local tbase2 = timepass%400
 local tbase3 = timepass%800 
 local ix = 0
 for ix=0,239 do 
  _1wav=cos(((115+ix-timepass)/1.25)/2*mPi)+3*cos(((115+ix-timepass)/24)/2*mPi)
  _2wav=cos((115+ix-timepass)/1.75*mPi)+3*cos(((115+ix-timepass)/12)/2*mPi)
  _3wav=cos(((115+ix-timepass)/2.5)/2*mPi)
  line(ix,115+_1wav+_2wav+_3wav,ix,150,7)  
 end    
 -- First Rock
 elli(tbase2-20,119, 12, 9, 14)
 elli(tbase2-26,119, 8, 12, 14)  
 elli(tbase2-16,115, 5, 4, 13)  
 elli(tbase2-21,113, 3, 4, 13)    
 elli(tbase2-25,109, 3, 2, 13)      
 -- Second Rock
 elli(tbase1-90,119, 10,12, 14)
 elli(tbase1-96,119, 8, 12, 14)  
 elli(tbase1-96,115, 5, 4, 13)  
 elli(tbase1-91,113, 3, 4, 13)    
 elli(tbase1-95,109, 3, 2, 13)      
 print('Animation that is 100% tri free!', 239-tbase3,2,2)
 print('Animation that is 100% tri free!', 240-tbase3,3,4)
 print('Why won`t we embrace the beauty of ellipsoids, sines and cosines?', 439-tbase3,2,2)
 print('Why won`t we embrace the beauty of ellipsoids, sines and cosines?', 440-tbase3,3,4)
 
end 

function arm(pos)
 local bnc = 0
 local clr=12+pos  -- Color Shift for backarm
 local sx = pos*13 -- X Shift for back arm
 local sy = pos*4  -- Y Shift for back arm
 if pos == 0 then
  bnc = 2*sin(2*mPi*(Mframe/12))
 else
  bnc = 2*cos(2*mPi*(Mframe/12))
 end 
 elli(128+sx, 89+Ma+sy+bnc/2, 15,  9, clr+1)
 elli(126+sx, 87+Ma+sy+bnc/2,  7,  8, clr+1) 
 elli(106+sx, 92+Ma+sy+bnc,  8,  5, clr)
 elli(117+sx, 90+Ma+sy+bnc, 14,  6, clr) 
 elli(128+sx, 88+Ma+sy+bnc/2, 15,  8, clr)
 line(101+sx, 84+Ma+sy+bnc, 104+sx, 86+Ma+sy+bnc, clr)     
 line(101+sx, 84+Ma+sy+bnc, 103+sx, 86+Ma+sy+bnc, clr) 
 line(94+sx,  87+Ma+sy+bnc, 103+sx, 88+Ma+sy+bnc, clr)
 line(94+sx,  87+Ma+sy+bnc, 101+sx, 89+Ma+sy+bnc, clr)   
 line(94+sx,  87+Ma+sy+bnc, 100+sx, 90+Ma+sy+bnc, clr)
 line(94+sx,  91+Ma+sy+bnc, 100+sx, 91+Ma+sy+bnc, clr) 
 line(94+sx,  91+Ma+sy+bnc,  99+sx, 92+Ma+sy+bnc, clr)  
 line(94+sx,  91+Ma+sy+bnc,  99+sx, 94+Ma+sy+bnc, clr)   
 line(96+sx,  96+Ma+sy+bnc, 104+sx, 95+Ma+sy+bnc, clr)     
 line(95+sx,  96+Ma+sy+bnc, 100+sx, 96+Ma+sy+bnc, clr) 
 line(96+sx, 100+Ma+sy+bnc, 103+sx, 97+Ma+sy+bnc, clr)  
 line(96+sx, 100+Ma+sy+bnc, 105+sx, 98+Ma+sy+bnc, clr)   
end

function foot(pos)
 local clr=12+pos  -- Color Shift for backarm
 local sx = -3*pos -- X Shift for back arm
 local curfr = Mframe -- Mframe correction
 if pos == 1 then
  if Mframe > 6 then
   curfr = Mframe-6
  else
   curfr = Mframe+6
  end 
 end
-- We could pack this as X, Y, RX, RY and 
-- read it with a for loop
 if curfr == 1 then 
  elli(149+sx, 119+-22, 11, 6, clr)
  elli(137+sx, 132+-22,  7, 4, clr)  
  elli(142+sx, 125+-22,  6, 5, clr)  
  elli(149+sx, 125+-22,  3, 2, clr)    
  elli(130+sx, 129+-22,  3, 3, clr)  
  elli(127+sx, 127+-22,  2, 1, clr)      
  elli(140+sx, 129+-22,  5, 5, clr)  
 end
 if curfr == 2 then
  elli(144+sx, 124+-22,  7, 11, clr)
  elli(146+sx, 119+-22,  8, 8, clr)  
  elli(146+sx, 120+-22,  2, 1, clr)  
  elli(139+sx, 132+-22,  4, 3, clr)  
  elli(135+sx, 134+-22,  4, 1, clr)    
  elli(139+sx, 135+-22,  8, 0, clr)  
  elli(148+sx, 133+-22,  1, 1, clr)    
 end 
 if curfr == 3 then
  elli(161+sx, 117-22, 10, 10, clr) 
  elli(165+sx, 125-22,  7,  9, clr)   
  elli(165+sx, 133-22,  8,  2, clr)   
  elli(158+sx, 134-22,  3,  1, clr)     
  elli(168+sx, 131-22,  5,  4, clr)  
 end 
 if curfr == 4 then
  elli(169+sx, 115-22,  9, 10, clr)
  elli(170+sx, 119-22,  8, 10, clr)  
  elli(176+sx, 128-22,  7, 5, clr)    
  elli(176+sx, 131-22,  5, 4, clr)      
  elli(172+sx, 132-22,  4, 2, clr)        
  elli(167+sx, 134-22,  2, 1, clr)          
  elli(173+sx, 135-22,  5, 0, clr)  
  elli(176+sx, 124-22,  3, 3, clr)  
 end
 if curfr == 5 then
  elli(172+sx, 112-22, 11, 10, clr)
  elli(182+sx, 121-22,  7,  8, clr)  
  elli(186+sx, 127-22,  6,  8, clr)
  elli(178+sx, 120-22,  9,  6, clr)  
  elli(183+sx, 133-22,  6,  2, clr)  
  elli(177+sx, 134-22,  1,  1, clr)  
  elli(180+sx, 135-22,  4,  0, clr)  
 end
 if curfr == 6 then
  elli(182+sx, 121-22, 10,  6, clr)
  elli(195+sx, 120-22,  3,  8, clr)
  elli(191+sx, 117-22,  6,  4, clr)  
  elli(174+sx, 115-22,  8,  8, clr)  
  elli(197+sx, 126-22,  2,  5, clr)  
 end
 if curfr == 7 then
  elli(175+sx, 114-22, 8,  8, clr)
  elli(182+sx, 121-22, 8,  6, clr)  
  elli(190+sx, 116-22, 5,  4, clr)  
  elli(188+sx, 121-22, 3,  3, clr)    
  elli(194+sx, 113-22, 6,  4, clr)
  elli(201+sx, 117-22, 3,  3, clr)    
  elli(199+sx, 115-22, 3,  3, clr)  
 end
 if curfr == 8 then
  elli(168+sx, 119-22, 7,  9, clr)
  elli(173+sx, 127-22, 7,  5, clr)  
  elli(181+sx, 122-22, 4,  4, clr)    
  elli(177+sx, 124-22, 5,  5, clr)    
  elli(193+sx, 122-22, 3,  3, clr)        
  elli(187+sx, 119-22, 6,  4, clr)          
 end 
 if curfr == 9 then
  elli(165+sx, 125-22,11,  4, clr)
  elli(159+sx, 119-22, 8,  8, clr)  
  elli(177+sx, 132-22, 3,  3, clr)    
  elli(175+sx, 128-22, 4,  4, clr)   
  elli(175+sx, 125-22, 3,  3, clr)     
 end 
 if curfr == 10 then
  elli(142+sx, 118-22, 7,  5, clr)
  elli(150+sx, 122-22, 1,  8, clr)  
  elli(147+sx, 126-22, 3,  5, clr)    
  elli(146+sx, 124-22, 5,  1, clr)      
  elli(142+sx, 134-22, 2,  1, clr)  
  elli(144+sx, 132-22, 2,  2, clr)    
  elli(145+sx, 131-22, 2,  2, clr)      
 end 
 if curfr == 11 then
  elli(137+sx, 120-22, 5,  9, clr)
  elli(142+sx, 114-22,10,  5, clr)  
  elli(132+sx, 128-22, 5,  2, clr)    
  elli(127+sx, 130-22, 3,  1, clr)  
  elli(132+sx, 120-22, 0,  7, clr)    
  elli(139+sx, 127-22, 2,  2, clr)      
 end 
 if curfr == 12 then 
  elli(144+sx, 116-22, 9,  6, clr)  
  elli(139+sx, 121-22, 7,  4, clr)    
  elli(139+sx, 121-22, 7,  4, clr)      
  elli(133+sx, 126-22, 7,  3, clr)      
  elli(124+sx, 124-22, 2,  2, clr)        
  elli(125+sx, 125-22, 2,  2, clr)  
  elli(135+sx, 118-22, 2,  3, clr)    
  elli(131+sx, 128-22, 6,  2, clr)  
 end
end

function butterfly()
local absa = abs(Ma)
 if Mframe%3 == 0  then
  elli(41, 51+absa,  4,  5, 4) 
  elli(44, 56+absa,  3,  4, 4)   
  line(36, 52+absa, 40, 58+absa, 2)
  line(37, 52+absa, 41, 58+absa, 2)
  line(37, 52+absa, 34, 49+absa, 2)    
 end
 if Mframe%3 == 1  then
  elli(40, 51+absa,  3,  5, 4) 
  elli(43, 56+absa,  2,  4, 4)   
  line(36, 52+absa, 40, 58+absa, 2)
  line(37, 52+absa, 41, 58+absa, 2)  
  line(37, 52+absa, 34, 49+absa, 2)  
 end
 if Mframe%3 == 2  then
  elli(41, 51+absa,  4,  5, 4) 
  elli(44, 56+absa,  3,  4, 4)   
  line(36, 52+absa, 40, 58+absa, 2)
  line(37, 52+absa, 41, 58+absa, 2)  
  line(37, 52+absa, 34, 49+absa, 2)  
 end
 if Mframe%3 == 3  then   
  elli(42, 51+absa,  5,  5, 4) 
  elli(45, 56+absa,  4,  4, 4)  
  line(36, 52+absa, 40, 58+absa, 2)
  line(37, 52+absa, 41, 58+absa, 2)  
  line(37, 52+absa, 34, 49+absa, 2)  
 end
end

function tail()
 if Mframe%3 == 0  then
  line(182,  95+Ma, 207, 97+Ma, 12)      
  line(182,  96+Ma, 207, 98+Ma, 12)        
  line(207,  97+Ma, 221, 94+Ma, 12) 
  line(207,  98+Ma, 221, 95+Ma, 12)   
  elli(224, 95+Ma,  3,  4, 12)   
  elli(226, 95+Ma,  3,  3, 12)     
  elli(229, 95+Ma,  3,  2, 12)       
  elli(232, 95+Ma,  4,  1, 12)         
 end
 if Mframe%3 == 1 then
  line(182,  95+Ma, 207, 96+Ma, 12)      
  line(182,  96+Ma, 207, 97+Ma, 12)        
  line(207,  96+Ma, 221, 93+Ma, 12) 
  line(207,  97+Ma, 221, 94+Ma, 12)   
  elli(224, 94+Ma,  3,  4, 12)   
  elli(226, 94+Ma,  3,  3, 12)     
  elli(229, 94+Ma,  3,  2, 12)       
  elli(232, 94+Ma,  4,  1, 12)         
 end
 if Mframe%3 == 2 then
  line(182,  95+Ma, 207, 95+Ma, 12)      
  line(182,  96+Ma, 207, 96+Ma, 12)        
  line(207,  95+Ma, 221, 92+Ma, 12) 
  line(207,  96+Ma, 221, 93+Ma, 12)   
  elli(224, 93+Ma,  3,  4, 12)   
  elli(226, 93+Ma,  3,  3, 12)     
  elli(229, 93+Ma,  3,  2, 12)       
  elli(232, 93+Ma,  4,  1, 12)         
 end
 if Mframe%3 == 3 then
  line(182,  95+Ma, 207, 96+Ma, 12)      
  line(182,  96+Ma, 207, 97+Ma, 12)        
  line(207,  96+Ma, 221, 93+Ma, 12) 
  line(207,  97+Ma, 221, 94+Ma, 12)   
  elli(224, 94+Ma,  3,  4, 12)   
  elli(226, 94+Ma,  3,  3, 12)     
  elli(229, 94+Ma,  3,  2, 12)       
  elli(232, 94+Ma,  4,  1, 12)         
 end 
end

function bodydraw()
 elli(131, 37+Ma,  3, 14, 13)
 elli(132, 40+Ma,  4, 14, 13) 
 elli(137, 36+Ma,  3, 14, 12)
 elli(138, 39+Ma,  4, 14, 12) 
 elli(131, 42+Ma, 15, 10, 12)
 elli(131, 42+Ma, 15, 10, 12)
 elli(120, 50+Ma,  9, 10, 12) 
 elli(139, 51+Ma, 11, 16, 12) 
 elli(139, 72+Ma, 20, 25, 12)   
 elli(109, 62+Ma, 23, 15, 12) 
 elli(109, 64+Ma, 23, 15, 12) 
 elli(144, 82+Ma, 21, 29, 12)  
 elli(155, 84+Ma, 19, 19, 12)       
 elli(132, 85+Ma, 10, 15, 12)   
 elli(166, 96+Ma, 18, 22, 12)     
 elli(157, 103+Ma, 24, 15, 12) 
-- Eye
 line(122, 39+Ma, 126, 41+Ma, 15)
 line(126, 41+Ma, 129, 44+Ma, 15) 
 elli(120, 50+Ma, 1, 2, 9)
 ellib(122, 47+Ma, 4, 6, 15)
end

function animtimer(tictime)
 return math.floor((tictime % 60) / 5)+1
end

function animationcontroller()
 if (Mframe == 1) or (Mframe == 7) then
  a = -22
 end 
 if (Mframe == 2) or (Mframe == 8) then
  a = -24
 end 
 if (Mframe == 3) or (Mframe == 9) then
  a = -23
 end
 if (Mframe == 4) or (Mframe == 10) then
  a = -22
 end 
 if (Mframe == 5) or (Mframe == 11) then
  a = -20
 end 
 if (Mframe == 6) or (Mframe == 12) then
  a = -21
 end 
end

local moomin_st = 0
function moomin_init()
	moomin_st = _t
	sweetie16_init()
	salad(1,{apple,blueberry,starfruit},5000,1000)
	salad(2,{apple,avocado,mango},1000,2000)
	salad(3,{kiwi,pear,amiga},2500,2000)
	salad(4,{papaya,blueberry,strawberry},3000,2000)
end

function moomin()
 local timepass = (_t-moomin_st)/30
 cls()
 Mframe=animtimer(timepass)
 animationcontroller()
 background(timepass)
 arm(1) 
 foot(1)
 bodydraw()
 arm(0)
 foot(0) 
 tail()
 butterfly()
 foreground(timepass)
 overlay_defaults((_t-moomin_st),"51","MOOM")
end


function moomin_bdr(row)
 local timepass = (_t-moomin_st)/30
-- Palette schenanigans
 if row == 0 then
  setcolour(3, 0xef, 0x7d, 0x57)
  setcolour(4, 0xff, 0xcd, 0x75)
  setcolour(5, 0xa7, 0xf0, 0x70)
  setcolour(6, 0x38, 0xb7, 0x64)
  setcolour(12, 0xf4, 0xf4, 0xf4)  
  setcolour(13, 0x94, 0xb0, 0xc2)  
 end   
 if row == 120 then
  setcolour(3, 0xa3, 0x54, 0x3c)
  setcolour(4, 0xe4, 0x91, 0x01)
  setcolour(5, 0x5b, 0xb9, 0x13)
  setcolour(6, 0x22, 0x6d, 0x3b)
  setcolour(12, 0xbd, 0xbd, 0xbd)  
  setcolour(13, 0x54, 0x7a, 0x92)  
 end 
-- Copper bars 
 if (row < 80) and (row%4 == 0) then
  setcolour(1, 0, 100+row*2, 160+row*2)
 end
-- Reflect 
 if row > 119 then
  for index=0,239 do
   colour = pix(index,114-(row-119)*3)
   pix(index,row,colour)
-- Distortion
   poke(0x03FF9, 3*math.sin((119-row+timepass/6)/4*mPi))
  end 
 else
-- Don't distort if it's now water
  poke(0x03FF9, 0) 
 end 
end

