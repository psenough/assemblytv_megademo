
ceasefire_creds={
	"PS\nMANTRATRONIC",
	"SUULE\nGIGABATES",
	"GASMAN\nDAVE84",
	"JOBE\nJEENIO",
	"SUPEROGUE\nJTRUK",
	"TOBACH\nEVILPAUL",
	"KANEEL",
}

ceasefire_t=0
ceasefire_noise={}
ceasefire_particles={}
ceasefire_textNoise={}

CEASEFIRE_CRED_DURATION=100 -- how long should each credit be visible for?
CEASEFIRE_NOISE_SZ=256
CEASEFIRE_BUFW=200
CEASEFIRE_BUFH=40

ceasefire_st=0

function ceasefire_init()
	sweetie16_init()

	ceasefire_t=0
	ceasefire_st = _t

	math.randomseed(1234)
	ceasefire_st=0
	ceasefire_initNoise()
	ceasefire_initTextNoise()
	ceasefire_initParticles()

	salad(1,{starfruit},2000,1000)
	salad(2,{apple,avocado,mango},3000,2000)
	salad(3,{kiwi,meat,amiga,pineapple},5200,2000)
	salad(4,{pineapple,papaya,passionfruit},4000,2000)
end

function ceasefire()
	local txt1=nil
	local txt2=nil
	local T=ceasefire_t-50 -- delay first credit
	local credIdx=T//CEASEFIRE_CRED_DURATION
	local p1=math.min(1,(T%CEASEFIRE_CRED_DURATION)/50-.5)
	local p2=math.max(0,1-(T%CEASEFIRE_CRED_DURATION)/10)

	if ceasefire_creds[credIdx]~=nil then
		txt1=ceasesfire_getTxt(ceasefire_creds[credIdx],p1)
	end
	if ceasefire_creds[credIdx+1]~=nil then
		txt2=ceasesfire_getTxt(ceasefire_creds[credIdx+1],p2)
	end

	cls()

	ceasefire_updateParticles()
	ceasefire_drawParticles(1,400)
	ceasefire_flame(200,90-4,
		math.max(0,math.min(1,T/50))
	)
	ceasefire_match(200,90)
	ceasefire_drawParticles(401,#ceasefire_particles)

	if txt1~=nil then
		ceasefire_drawTxt(txt1)
	end
	if txt2~=nil then
		ceasefire_drawTxt(txt2)
	end
	ceasefire_t=ceasefire_t+1
	
	overlay_defaults((_t-ceasefire_st),"10","CNCD")
end

function ceasefire_initParticles()
	for i=1,500 do
		ceasefire_particles[i]=ceasefire_createParticle(i)
	end
end

function ceasefire_initNoise()
  math.randomseed(17)
  for octave=1,5 do
    -- Geneate random values
    values={}
    for i=1,CEASEFIRE_NOISE_SZ^2 do
      values[i]=math.random()
    end

    step=2^octave -- increase step size for each octave in powers of two
    numSteps=CEASEFIRE_NOISE_SZ//step -- number of step repetitions in table
    for y=0,CEASEFIRE_NOISE_SZ-1 do
      for x=0,CEASEFIRE_NOISE_SZ-1 do
        -- Get cells from values grid to interpolate
        x1=(x//step)%numSteps
        y1=(y//step)%numSteps
        x2=(x1+1)%numSteps
        y2=(y1+1)%numSteps
        a=values[x1+y1*numSteps+1] -- upper left cell
        b=values[x2+y1*numSteps+1] -- upper right cell
        c=values[x1+y2*numSteps+1] -- lower left cell
        d=values[x2+y2*numSteps+1] -- lower right cell

        -- 2d interpolation to get current value
        mx=x%step/step
        my=y%step/step
        A=a+(b-a)*mx^2*(3-2*mx) -- smoothstep
        B=c+(d-c)*mx^2*(3-2*mx)
        v=A+(B-A)*my^2*(3-2*my)

        -- Accumulate values for each octave in table
        k=x+y*CEASEFIRE_NOISE_SZ+1
        ceasefire_noise[k]=(ceasefire_noise[k] or 0)+v
        *step -- multiply by step size so magnitude decreases with frequency
      end
    end
  end
end

function ceasefire_initTextNoise()
	for x=0,CEASEFIRE_BUFW-1 do
		ceasefire_textNoise[x+1]={}
		for y=0,CEASEFIRE_BUFH-1 do
			ceasefire_textNoise[x+1][y+1]=math.random()
		end
	end
end

function ceasefire_drawTxt(txt)
	for i=1,#txt.px do
		pix(
			30+txt.px[i][1],
			80+txt.px[i][2],
		12)
	end
end

function ceasesfire_getTxt(str,thresh)
	local txtPx={}
	local w=0
	rect(0,0,CEASEFIRE_BUFW,CEASEFIRE_BUFH,0)
	print(str,0,0,1,false,2)
	for x=0,CEASEFIRE_BUFW-1 do
		for y=0,CEASEFIRE_BUFH-1 do
			if peek4(y*240+x)==1 then
				w=math.max(x,w)
				if ceasefire_textNoise[x+1][y+1]>thresh then
					table.insert(txtPx,{x,y})
				end
			end
		end
	end
	return {px=txtPx,w=w}
end

function ceasefire_drawParticles(f,t)
	for i=f,t do
		local p=ceasefire_particles[i]
		circ(
			120+p.x*100/p.z,
			68+p.y*100/p.z,
			400//p.z,
			math.min(4,math.max(1,4-p.z/20+p.l/10))
		)
	end
end

function ceasefire_match(ox,oy)
	local lines={13,10,32,7,16,29}
	rect(ox-5,oy,11,100,4)
	for i=0,5 do
		rect(ox-5+i*2,oy,1,lines[i+1],3)
	end
	elli(ox,oy-5,6,8,12)
end

function ceasefire_flame(ox,oy,s)
	for y=-100,20 do
		for x=-40,40 do
			local n=ceasefire_getNoise(x,y+ceasefire_t)
			local d=(x^2+y^2)^.5
			local c=(n*8-d*15-y*10)*s
			if c>30 then
				local col=(c-30)/20
				pix(ox+x,oy+y,
				col<3 and col+2 or 12)
				--c>60 and 12 or)
			end
		end
	end
end

function ceasefire_createParticle(i)
	return {
		x=math.random()*600-300,
		y=math.random()*600-300,
		z=501-i,
		l=50+math.random()*100,
		vx=math.random()-.5,
		vy=math.random()-.5,
	}
end

function ceasefire_updateParticles()
	for i=1,#ceasefire_particles do
		local p=ceasefire_particles[i]
		if p.l<0 then
			ceasefire_particles[i]=ceasefire_createParticle(i)
		else
			p.l=p.l-1
			p.x=p.x+p.vx/4
			p.y=p.y+p.vy/4
			p.z=p.z-.05
			--if p.z<50 then
				--p.z=p.z+600
			--end
		end
	end
end

function ceasefire_getNoise(x,y)
 	return ceasefire_noise[(y%CEASEFIRE_NOISE_SZ)*CEASEFIRE_NOISE_SZ+x%CEASEFIRE_NOISE_SZ+1]
end
