
-------------------------------------
-- title screen


local title_screen_st=0
function title_screen_init()
	title_screen_st=_t
	sweetie16_init()
	salad(1,{banana,apple},1000,200)
	salad(4,{cherry},1000,200)
end

function title_screen()
	local t=(_t-title_screen_st)/99
	local g=t/4
	local s=math.sin
	local p=(g//4)&8
	for o=0,32640 do
		local x=o%240-120
		local y=o/240-56
		local z=3-(x*x+y*y)/499
		local q=z<-(3+s(g)) and(x/z+g)//1&(y/z)//1 or 12
		poke4(o,-(q&3))
	end 
	--elli(120,56,100,50,0)
	for i=0,5 do
		local a=g+i/2
		local X=s(a)*64
		local Y=s(a-11)*16
		circ(120+X,Y+64,Y/2+3,Y/4)
	end
	print("AssemblyTV",42,50,0,1,3)
	print("AssemblyTV",40,48,t,1,3)
	print("M E G A D E M O",91,73,0,1,1,1)
	print("M E G A D E M O",90,72,t,1,1,1)

	--spr(224,(240-128)/2+math.sin(t)*5,15+math.sin(t/2)*5,0,1,0,0,16,2)
		
	overlay_defaults((_t-title_screen_st),"74","MEGA")
end
