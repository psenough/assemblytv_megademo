
birds_cctv_st = 0
function birds_cctv_init()
  birds_cctv_st = _t
  sweetie16_init()
end


function birds_cctv()
    local t = (_t-birds_cctv_st) // 320
    cls(8)
    --for i = 0, 4 do
    --    rect(0, -40 + i * 36, 240, 50, i)
    --end

    -- clouds innit
    elli(290 - t % 340, 20, 40, 5, 13)
    elli(340 - t / 1.3 % 480, 40, 40, 5, 13)
    elli(270 - t / 1.2 % 480, 30, 40, 6, 13)

				t=380
    building(250 - t % 400, 60, 14)
    building(320 - t * 1.4 % 400, 70, 13)
    building(310 - t * 1.7 % 400, 80, 14)
    building(300 - t * 1.9 % 400, 85, 15)

    pval = t * 3 % 480
    birds_lines(240 - pval,20)
	birds_lines(240 - pval,40)
    birds_lines(-240 - pval,20)
    birds_lines(-240 - pval,40)
    pole(250 - pval,0)

	rect(90,40,150,140,13)
	rect(100,50,40,40,0)
	rect(150,50,40,40,0)
	rect(200,50,40,40,0)
    rect(100,100,40,40,0)
	rect(150,100,40,40,0)
	rect(200,100,40,40,0)
    birb(130 - t * 3 % 480, 42, 0)
    birb(170 - t * 3 % 480, 42, 4)
    birb(190 - t * 3 % 480, 92, 8)
	
	overlay_defaults((_t-birds_cctv_st),"68","CCTV")
end

function birds_lines(x,y)
    for i = 0, 480 do
        pix(x + i, y + math.sin(i / 128) * 8, 0)
        pix(x + i, y+1 + math.sin(i / 128) * 8, 15)
    end
end

function building(x, y, col)
    rect(x + 0, y + 0, 41, 120, col)
    for j = 0, 16 do
        for i = 0, 4 do
            rect(x + i * 8 + 2, y + j * 8 + 2, 5, 5, 4)
        end
    end
end

function pole(x,y)
    rect(-12 + x, y+15, 30, 6, 14)
    rect(-12 + x, y+35, 30, 6, 14)
    rect(0 + x, y+10, 5, 150, 15)
end

function birb(x, y, offset)

	local t = time()/200
    t2 = math.sin(t / 2 + offset) / 2

    for i = 0, 2 do
        line(x + 175, y + 44, x + 165 + i * 3, y + 47, 3)
    end

    elli(x + 170, y + 35 + math.sin(t2), 13, 9, 15)
    elli(x + 183, y + 35 + math.sin(t2 + 0.3), 10, 2, 15)
    elli(x + 175, y + 33 + math.sin(t2 + 0.6) * 1.15, 10, 4, 14)

    for i = 0, 3 do
        circ(x + 158 - i * math.sin(t2 + 0.75) * 1.5, y + 32 - i * 2 * math.cos(t2 + 0.075), 3, 14)
    end
    circ(x + 152 + math.sin(t2 + 3) * 3, y + 26 - math.sin(t2 + 3) * 4, 1, 3)
end