
-----------------------------------------
-- fruit sprite ids

banana = 1
pear = 3
apple = 5
kiwi = 7
watermelon = 9
orange = 11
peach = 13
strawberry = 33
cherry = 35
pineapple = 37
plum = 39
starfruit = 41
papaya = 43
avocado = 45
blueberry = 65
grapes = 67
passionfruit = 69
mango = 71
fig = 73
amiga = 75
meat = 77
null = 97

ripe_time = 2500 -- time the fruit stays on screen

-- { person id, fruit id, time delay }
fruit_salad = {}

function salad(pl, seq, min, delay)

	-- dont add salad if we are jumping to a certain scene
	-- else the old fruits will get played first and screw up the preview
	--if current_scene_id <= track_start * 16 + patt_start then
		--trace("canceled")
	--	return
	--end

	math.randomseed(_t+pl+min+delay)
	local fruit = seq[math.random(1,#seq)]
	local rd = math.random(min,min+delay)
	--trace(pl .. " " .. min .. " " .. (min+delay) .. " " .. rd)
	table.insert(fruit_salad,{pl,fruit,_t+rd})

	if pl == 1 and fruit == banana then
		salad(2,{banana,apple,pear,null},rd,2000)
		salad(3,{banana,banana,pear,kiwi,null},rd,2000)
		salad(4,{banana,null},rd,3000)
	end
	if pl == 1 and fruit == apple then
		salad(2,{banana,apple,apple,null},rd,2000)
		salad(3,{banana,apple,null},rd,2000)
		salad(4,{banana,apple,null},rd,3000)
	end
	if pl == 1 and fruit == pear then
		salad(2,{pear,kiwi,null},rd,2000)
		salad(3,{banana,pear,kiwi,null},rd,2000)
		salad(4,{pear,cherry,plum,null},rd,3000)
	end
	if pl == 1 and fruit == watermelon then
		salad(2,{watermelon,banana,null},rd,2000)
		salad(3,{watermelon,pear,apple,starfruit,null},rd,2000)
		salad(4,{watermelon,null},rd,2000)
	end
	if pl == 1 and fruit == amiga then
		salad(2,{amiga,null},rd,2000)
		salad(3,{amiga,null},rd,2000)
		salad(4,{amiga,null},rd,2000)
	end
	if pl == 1 and fruit == meat then
		salad(1,{amiga,meat,null},rd,2000)
		salad(2,{amiga,meat,null},rd,2000)
		salad(3,{amiga,meat,null},rd,2000)
	end
end

function fruit_emoji(x,y,fruit)
	circ(x+8,y+8,12,0)
	circ(x+8,y+8,10,12)
	spr(fruit,x,y,15,1,0,0,2,2)
end

function fruit_emoji_pop(x,y,fruit,st,et,t)
	circ(x+8,y+8,12,0)
	circ(x+8,y+8,10,12)
	spr(fruit,x,y,15,1,0,0,2,2)
end

function fruit_emoji_pop(x,y,fruit,st,et,t)
	local ntime = (t-st)/(et-st)
	local ntimeout = 1.-ntime
	local ease = easeOutHack(ntime*2)
	local easeout = 1.0-easeOutHack(ntimeout)
	--print(ease,0,0,12)
	circ(x+7,y+7,ease*13+easeout*12,0)
	circ(x+7,y+7,ease*11+easeout*10,12)
	if ntime > .1 and ntime < .85 then
		spr(fruit,x,y,15,1,0,0,2,2)
	end
end

function fruit_salad_layer()

	local marked = false
	local fscount = #fruit_salad
	
	if fscount == 0 then return end
	
	-- paint fruit
	for i=1,fscount do
		if fruit_salad[i] ~= nil then
			local pl = fruit_salad[i][1]
			local sp = fruit_salad[i][2]
			local tt = fruit_salad[i][3]
			if _t > tt then
				if _t < tt+ripe_time and sp ~= null  then
					fruit_emoji_pop(pl*54-20,110,sp,tt,tt+ripe_time,_t)
					-- remove other fruits planned for this player
					-- if they are happening within this timeframe
					-- to avoid overlapping / conflict
					for j=1,fscount do
						if j~=i and fruit_salad[j] ~= nil then
							if fruit_salad[j][1] == pl and fruit_salad[j][3] < tt+ripe_time then
								--trace("marking " .. j .. " when i is " .. i)
								fruit_salad[j] = nil
								marked = true
							end
						end
					end
				else
					fruit_salad[i] = nil
				end
			end
		end
	end
	
	-- compact fruit array if something has been removed
	-- because doing it while iterating was crashing things
	-- fuckings to lua
	local j = 0
	for i=1,fscount do
		if fruit_salad[i]~=nil then
			j=j+1
			fruit_salad[j]=fruit_salad[i]
		end
	end
	for i=j+1,fscount do
		fruit_salad[i]=nil
	end
end
