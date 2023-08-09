
function noise_switch_init()
	--sync(8 | 16, 0)
	for i=0,15 do
		poke(0x3FC0+i*3  ,i*16)
		poke(0x3FC0+i*3+1,i*16)
		poke(0x3FC0+i*3+2,i*16)
	end
end

function noise_switch()
	for i=0,600 do
		pix(math.random(0,240),math.random(0,136),math.random(0,15))
	end
	
	overlay_defaults(0,"","")
end

function noise_switch_bdr(l)
	poke(0x3ffa,math.sin(time()/80+l/32)*math.sin(time()/400+l/64)*math.random(20)+l)
	poke(0x3ff9,math.sin(time()/100+l/12)*math.sin(time()/10)*math.random(20)+l*.1)
end
