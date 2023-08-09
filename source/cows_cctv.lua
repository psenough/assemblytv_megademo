
cows_cctv_st = 0
function cows_cctv_init()
  cows_cctv_st = _t
  sweetie16_init()
end

function cows_cctv()
	local t=(_t-cows_cctv_st)/10

	cls(6)
	
	vbank(1)
	cls()
	vbank(0)
	
	math.randomseed(1)
	for y=-10,40 do
		grass(y,(y+12)/50,math.random()*120+y)
		if y==0 then
			lake(150,30,1)
		 cow(0,5,10,1,time()/120)
		end
		if y==9 then
		 for i=0,12 do	
				birds(120+math.random()*20,
							0+math.random()*20,
							math.random()*2,
							0)
			end
	 end
		if y==10 then
		 cow(30,30,12,19,time()/140)
			cow(160,22,13,219,time()/340)
		end
		if y==30 then
			cow(15,60,23,9,time()/220)
		end
	end
	
	cow(100,44,40,11,time()/200)
	
	overlay_defaults((_t-cows_cctv_st),"67","CCTV")
end


function cow(x,y,w,seed,t)

	math.randomseed(seed)
	
	-- body
	rect(x+w*.5,y+w*.5,w*3,w*2,12)
	clip(x+w*.5,y+w*.5,w*3,w*2)
	-- spots on body
	for i=0,15 do
		rect(x+w*(.5+math.random()*2),
							y+w*(.5+math.random()*2),
							w*3*(math.random()*.45),
							w*2*(math.random()*.5),
							15)
	end
	clip()
 
	-- legs
	rect(x+w*.5,y+w*2,w*.8,w,12)
	rect(x+w*2.7,y+w*2,w*.8,w,12)
	
	-- left horn
	clip(x+w*.35-w*.3+1,y-w, w*.15,w)
	circ(x+w*.35,y-w*.1,w*.3,14)

	-- right horn
	clip(x+w*.62+w*.15,y-w, w*.15,w)
	circ(x+w*.62,y-w*.1,w*.3,14)
	clip()
	
	-- left ear
	elli(x-w*.2,y+w*.2,w*.4,w*.2,15)
	elli(x-w*.2,y+w*.2,w*.3,w*.1,14)
	
	-- right ear
	elli(x+w*1.2,y+w*.2,w*.4,w*.2,12+math.random()*2//1*3)
	elli(x+w*1.2,y+w*.2,w*.3,w*.1,14)
	
	--head block
	rect(x,y,w,w,12)
	
	-- eyes
	circ(x+w*.3,y+w*.3,w*.1,15)
	circ(x+w*.7,y+w*.3,w*.1,15)
	
	-- mouth
	rect(x,y+w,w,w*.25,4)
	rect(x+w*.3,y+w*1.25,w*.4,w*.1,2)
	rect(x+math.sin(t/2)+1,y+w*1.3+math.sin(t)*2,w,w*.2,4)

	-- nostrils
	circ(x+w*.3,y+w*1.05,w*.05,3)
	circ(x+w*.65,y+w*1.05,w*.05,3)

end

-- stolen from ToBach!
function grass(y,dy,t)
	for i=0,250 do
		line((i-t)%250,
							(100+math.sin(i)*10)*dy+y,
							(i-t)%250,
							135*dy+y,7)
	end
	for i=0,250 do
		dx=(i-t)%250
		line(dx-3+math.sin(time()/500+i)*2,
							(110+math.sin(i)*10)*dy+y,
							dx,
							135*dy+y,6)
	end
end

function birds(x,y,seed,c)
	dx=x+math.sin(time()/1000+seed)*25+math.sin(time()/500+11+seed)*20
	dy=y+math.sin(time()/1000+seed)*10+math.sin(time()/800+1+seed)*20
	pix(dx,dy,c)
end

function lake(x,y,t)
	local dx=x-t
	elli(dx,y,120,20,8)
	elli(dx+5,y-4,90+math.sin(time()/9000)*2,10+math.sin(time()/8000)*2,9)
	for i=0,20 do
			vx=dx+math.random(80)-40+math.sin(time()/800+i*200)*2
			vy=y-12+math.random(10)
		line(vx,
							vy,
							vx+math.random(20),
							vy,
							math.random(3)+9)
	end
end
