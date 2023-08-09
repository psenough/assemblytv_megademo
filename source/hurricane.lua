
hurricane_st = 0
function hurricane_init()
  hurricane_st = _t
  sweetie16_init()
end

function hurricane()
	cls()
	--local t=(_t-hurricane_st)/999
	local o=0
	for o=0,136 do 
		local s0=math.sin((_t-hurricane_st)/1999)*99
		local s2=math.sin(((_t-hurricane_st)-o)/539-o*2)*16
		local s=s2+math.cos(((_t-hurricane_st)+o+s2)/299)*16 
		rect(0,o,240,1,8+o/64+o/2%2)
		rect(s+64+s0,o,s2,1,12+(s2/6)%3)
		rect(s+s2+63+s0,o,s,1,15-(s2/6)%3)
	end
	grass(6,1,(_t-hurricane_st)/999)
	
	overlay_defaults((_t-hurricane_st),"70","WTHR")
end
