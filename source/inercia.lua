
inercia_st = 0
function inercia_init()
	inercia_st = _t
	sweetie16_init()
	salad(1,{banana},3000,1000)
	salad(4,{kiwi},4000,2000)
end

function inercia()

	local strobe = 300
	local t=_t%strobe

	local str = "...and don't forget to"
	local str2 = "come to inercia demoparty 2005!!!"
	local posx = 65
	local posy = 50
	local posx2 = 35
	local posy2 = posy+20

	if t>strobe/2 then
		cls()
		poke(0x3FF8,0)
		print(str,posx,posy,12,false,1,false)
		print(str2,posx2,posy2,12,false,1,false)
	else
		cls(12)
		poke(0x3FF8,12)
		print(str,posx,posy,0,false,1,false)
		print(str2,posx2,posy2,0,false,1,false)
	end
	
	overlay_defaults(_t-inercia_st,"05","DONT")

end
