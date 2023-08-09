
mPi=math.pi
mTwoPi=mPi*2
mAbs=math.abs
mAtan2=math.atan2
mMax=math.max
mMin=math.min
mRandom=math.random
mCos=math.cos
mSin=math.sin
mSqrt=math.sqrt
function mClamp(a,min,max)
 if a<min then return min
 elseif a>max then return max
 else return a
 end
end
function mLerp(a,min,max)
 return min+(max-min)*a
end
function easeOutCubic(x)
 return 1 - math.pow(1 - x, 3)
end
function easeOutHack(x)
	if x == 0 then
		return 0
	else
		if x == 1 then
			return 1
		else
			return math.pow(2, -20 * x) + 1
		end
	end
end

function no_fn()
end

function sweetie16_init()
	tovram(sweetie16_pal)
	poke(0x3FF8,0) -- border
	poke(0x3FF9,0) -- screen offset
	poke(0x3FFA,0)
	vbank(1)
	poke(0x03FF8, 15)
	vbank(0)
	--for i=0,15 do poke4(0x3ff0 *2 +i,i) end
end

tv_id_uptime = 2000
function tv_channel_id(ch,label)
	print(ch,6,6,6,true,4,false)
	print(label,6,30,6,true,2,false)
end

function overlay_defaults(t,ch_number,ch_label)
	vbank(1)
	poke(0x03FF8, 15)
	cls(15)
	if t < tv_id_uptime then
		tv_channel_id(ch_number,ch_label)
	end
	fruit_salad_layer()
	vbank(0)
end


sweetie16_pal = "1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57"

-- set the palette
function tovram(str)
  local o=0
  for c=1,#str,2 do -- walk colors
    local v=tonumber(str:sub(c,c+1),16) -- get color (v)alue
    poke(0x3fc0+o,v) o=o+1 -- set color
  end
end

-- decode gfx into sprites
function tomem(str)
  local o=tonumber(str:sub(1,2),16)*256 -- get (o)ffset
trace(o)
  local w=tonumber(str:sub(3,4),16)*8-1 -- get (w)idth
  local e=str:sub(5,str:len()) -- remove header to get (e)ncoded data
  local d = "" -- (d)ecoded data
  for m, c in e:gmatch("(%u+)([^%u]+)") do -- decode rle, (m)atch & (c)ounter
    d = d .. m .. (m:sub(-1):rep(c))  
  end
  local y=0
  for x = 1,#d,1 do -- write to mem
    local c=string.byte(d:sub(x,x))-65 -- get (c)olor value
    poke4(o+y,c) y=y+1
    if y>w then y=0 o=o+1024 end
  end
end

-- debug profiler
f=0
ftimes={}
function ftime()
    ftimes[f%20+1]=time()-_t
    f=f+1
    local total=0
    for i=1,#ftimes do
        total=total+ftimes[i]
    end
    return math.floor(total/#ftimes)
end
