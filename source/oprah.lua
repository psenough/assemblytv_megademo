
--------------------------------------
--- oprah fingerprint reader

oprah_slices1={0,4,4,8,9,12,15,21,21,24,24,27,27}
oprah_slices2={0,3,5,7,10,14,14,16,19,22,28,28,31,31,35,35,35,35}

oprah_armv0={{0,-8},{0,8},{-40,0},{-40,16},
 {-50,-2},{-50,10},{-80,-12},{-80,-4}}
oprah_armv1={}

oprah_st = 0
oprah_reset_timmings = false


function oprah_init()
	oprah_st = _t
	oprah_reset_timmings = false
	sweetie16_init()
	-- make palette 3 brown (not orange)
	poke(16329,0xa0)
	poke(16330,0x52)
	poke(16331,0x2d)
end

oprah_split_scene = 20

function oprah()
	if _row < oprah_split_scene then
		oprah_scene1()
	else
		if oprah_reset_timmings == false then
			oprah_st = _t-150*2
			oprah_reset_timmings = true
		end
		oprah_scene2()
	end
end

function oprah_scene1()
	local t=(_t-oprah_st)
 --oprahscene=1
 cls(15)
 local arma=(math.cos(t/250)+1)*0.3
 local armspin=0.9-math.sin(t/550)*0.25
 local lean=arma*8
 local ca=math.cos(arma)
 local sa=math.sin(arma)
 local speak=math.sin(t/50)
 -- scenery
 rect(0,0,20,136,1)
 rect(15,0,239,80,4)
 rect(30,0,239,60,14)
 tri(80,0,60,30,100,0,9)
 tri(200,0,140,50,240,0,9)
 rect(0,85,239,5,4)
 rect(0,90,239,10,3)
 rect(0,105,239,10,3)
 rect(0,125,239,20,13)
 -- suit
 tri(140,120,175,120,180,136,2)
 tri(140,120,180,136,135,136,2)
 elli(156,120,19,3,1)
 tri(137,60,170,60,175,120,2)
 tri(137,60,175,120,125,84,2)
 tri(132,95,175,120,125,84,2)
 tri(132,95,175,120,136,120,2)
 tri(140,60,160,60,140,80,3)
 tri(140,60,140,80,142,77,1)

 -- buttons
 circ(148,92,2,0);circ(148,92,0.5,12)
 circ(150,105,2,0);circ(150,105,0.5,12)

 -- microphone
 elli(126,67-lean,4,6,0)
 rect(124,72-lean,5,18,0)
 elli(128,78-lean,5,4,1)
 elli(127,77-lean,5,4,3)

 -- top hair
 elli(152+lean,24-lean/2,20,10,0)
 -- left hair
 elli(140+lean,37-lean/2,15,10,0)

 -- elli(140,35,10,20,0)
 -- head
 elli(148+lean,42-lean/2,16,20,3)
 -- eyes
 tri(
  141+lean,35-lean/2,
  141+lean,39-lean/2,
  147+lean,37-lean/2,
  0)
 pix(143+lean,38-lean/2,13)
 line(
  143+lean,33-lean/2,
  149+lean,32-lean/2,
  0)

 tri(
  132+lean,35-lean/2,
  132+lean,39-lean/2,
  138+lean,37-lean/2,
  0)
 pix(133+lean,38-lean/2,13)
 line(
  133+lean,33-lean/2,
  137+lean,33-lean/2,
  0)

 -- chin
 elli(
  138+lean,55+speak*2-lean/2,
  3,3,3)
 -- mouth
 tri(
  143+lean,49-lean/2,
  133+lean,51+-lean/2,
  135+lean,54+speak*2-lean/2,
  1)
 line(
  142+lean,50-lean/2,
  133+lean,50-lean/2,
  2)
 tri(
  140+lean,50+speak-lean/2,
  134+lean,53+speak*2-lean/2,
  136+lean,55+speak*2-lean/2,
  13)
 line(
  139+lean,51-lean/2,
  134+lean,51-lean/2,
  12)
 tri(
  142+lean,49-lean/2,
  134+lean,54+speak*2-lean/2,
  136+lean,57+speak*2-lean/2,
  2)

 -- nose
 line(
  135+lean,46-lean/2,
  138+lean,46-lean/2,
  1)
 line(
  138+lean,46-lean/2,
  139+lean,45-lean/2,
  1)
 
 -- right hair
 elli(162+lean,25,12,10,0)
 elli(165+lean,35,15,10,0)
 elli(170+lean,45,18,10,0)
 -- arm
 local shoulderx=164
 local shouldery=66
 for i=1,8 do
  local x0=oprah_armv0[i][1]
  local y0=oprah_armv0[i][2]
  oprah_armv1[i]={(ca*x0-sa*y0)*armspin+shoulderx,ca*y0+sa*x0+shouldery}
 end
 elli(shoulderx+1,shouldery+1,6,7,1)
 elli(shoulderx,shouldery,6,7,2)
 tri(oprah_armv1[1][1],oprah_armv1[1][2],oprah_armv1[2][1],oprah_armv1[2][2],oprah_armv1[3][1],oprah_armv1[3][2],2)
 tri(oprah_armv1[2][1],oprah_armv1[2][2]+2,oprah_armv1[3][1],oprah_armv1[3][2]+2,oprah_armv1[4][1],oprah_armv1[4][2],1)
 tri(oprah_armv1[2][1],oprah_armv1[2][2],oprah_armv1[3][1],oprah_armv1[3][2],oprah_armv1[4][1],oprah_armv1[4][2],2)
 tri(oprah_armv1[3][1],oprah_armv1[3][2],oprah_armv1[4][1],oprah_armv1[4][2],oprah_armv1[5][1],oprah_armv1[5][2],2)
 tri(oprah_armv1[4][1],oprah_armv1[4][2],oprah_armv1[5][1],oprah_armv1[5][2],oprah_armv1[6][1],oprah_armv1[6][2],2)
 tri(oprah_armv1[5][1],oprah_armv1[5][2],oprah_armv1[6][1],oprah_armv1[6][2],oprah_armv1[7][1],oprah_armv1[7][2],3)
 tri(oprah_armv1[6][1],oprah_armv1[6][2],oprah_armv1[7][1],oprah_armv1[7][2],oprah_armv1[8][1],oprah_armv1[8][2],3)
 -- finger
 elli(oprah_armv1[7][1]-4-armspin,oprah_armv1[7][2]+3,5*armspin,1,1)
 elli(oprah_armv1[7][1]-3-armspin,oprah_armv1[7][2]+2,5*armspin,1,3)
 -- hand
 elli(
  (oprah_armv1[7][1]+oprah_armv1[8][1])/2-1,
  (oprah_armv1[7][2]+oprah_armv1[8][2])/2+2,
  3,4,1
 )
 elli(
  (oprah_armv1[7][1]+oprah_armv1[8][1])/2,
  (oprah_armv1[7][2]+oprah_armv1[8][2])/2+1,
  3,5,3
 )

 local beat=(t//104)%(#oprah_slices1)
 local slice=oprah_slices1[beat+1]
 if slice==0 then
  str1=""
 else
  str1=string.sub("YOU GET A",1,slice)
 end
 if slice<10 then
  str2=""
 else
  str2=string.sub("FINGERPRINT READER",1,slice-9)
 end
 print(str1,71,96,0,false,2)
 print(str1,70,95,12,false,2)
 print(str2,16,111,0,false,2)
 print(str2,15,110,12,false,2)
 
 overlay_defaults((_t-oprah_st),"42","OPRA")
	
end

--function oprah2_init()
--	oprah_st=_t
--end

function oprah_scene2()
	local t=(_t-oprah_st)%5200
 --oprahscene=2
 cls(11)

 local r=math.sin(t/25)
 -- hair
 elli(120,15+r*2,30,19,0)
 elli(99+r*4,40,15,30,0)
 elli(142+r*4,40,16,30,0)
 -- earrings
 elli(102+r,34,1,4,14)
 elli(138+r,34,1,4,14)
 -- suit
 tri(90,50,80,115,160,115,2)
 tri(90,50,150,50,160,115,2)
 elli(120,115,40,5,1)
 tri(82,113,75,136,165,136,2)
 tri(82,113,165,136,158,113,2)
 -- arms
 tri(72,42-r,45,27-r,67,55-r,3)
 tri(45,27-r,67,55-r,40,37-r,3)
 tri(188,31+2*r,230,10+2*r,198,44+2*r,3)
 tri(230,10+2*r,198,44+2*r,235,20+2*r,3)
 tri(225,12+2*r,227,12+2*r,230,25+2*r,2)
 tri(227,12+2*r,230,25+2*r,231,23+2*r,2)
 elli(238,12+2*r,10,7,3)
 -- hand/microphone
 rect(38-r*2,36-r,5,10,0)
 elli(41-r*2,32-r,4,6,1)
 elli(40-r*2,30-r,4,6,3)
 elli(40-r*2,22-r,5,7,0)
 -- sleeves
 tri(90,50,70,40-r,90,80,2)
 tri(70,40-r,90,80,65,55-r,2)
 tri(150,50,190,30+2*r,150,80,2)
 tri(190,30+2*r,150,80,200,45+2*r,2)
 -- buttons
 circ(105,75,3,0);circ(105,75,1,12)
 circ(135,75,3,0);circ(135,75,1,12)
 circ(103,90,3,0);circ(103,90,1,12)
 circ(137,90,3,0);circ(137,90,1,12)
 -- neck
 tri(110,51,130,51,120,58,3)
 rect(110,45,20,6,3)
 -- face
 elli(121-r,29,18,21,1)
 elli(120-r,27,18,21,3)
 -- mouth
 elli(120-2*r,35,7,8.5,2)
 elli(120-2*r,35,6,6,13)
 elli(120-2*r,36,6,6,1)
 elli(120-3*r,38,5,3,2)
 -- nose
 rect(117.5-2.5*r,23,2,2,0)
 rect(121.5-2.5*r,23,2,2,0)
 -- eyes
 tri(117-2*r,19,117-2*r,15,104-2*r,21,0)
 tri(123-2*r,19,123-2*r,15,136-2*r,21,0)
 -- eyebrows
 tri(116-2*r,16,116-2*r,13,105-2*r,13,15)
 tri(124-2*r,16,124-2*r,13,135-2*r,13,15)

 local beat=(t//150)%(#oprah_slices2)
 local slice=oprah_slices2[beat+1]
 if slice==0 then
  str1=""
 else
  str1=string.sub("EVERYBODY GETS",1,slice)
 end
 if slice<15 then
  str2=""
 else
  str2=string.sub("A FINGERPRINT READER!",1,slice-14)
 end
 
 print(str1,41,91,0,false,2)
 print(str1,40,90,12,false,2)
 print(str2,6,106,0,false,2)
 print(str2,5,105,12,false,2)
end

function oprah_bdr(y)
	if _row >= oprah_split_scene then
	  if y<20 then
	   poke(16353,0x66)
	   poke(16354,0x33)
	   poke(16355,0x99)
	  elseif y<30 then
	   poke(16353,0xf4)
	   poke(16354,0xa4)
	   poke(16355,0x60)
	  elseif y<60 then
	   poke(16353,0x4b)
	   poke(16354,0x00)
	   poke(16355,0x82)
	  elseif y<100 then
	   poke(16353,0xbc)
	   poke(16354,0x8f)
	   poke(16355,0x8f)
	  else
	   poke(16353,0xf4)
	   poke(16354,0xa4)
	   poke(16355,0x60)
	  end
	end
end
