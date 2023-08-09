function variform_init()
s=1t=0w=64
end

function variform()
cls(0)for i=0,136,2 do line(0,i,240,i,15)end
t0=time()/30
sz=17
for i=0,sz*sz*sz do 
x=i%sz-8
y=(i/sz)%sz-8
z=(i/(sz*sz))-8
m=t*z-s*y-7
n=s*z+t*y
x2=x+math.sin(t+x*16)*4
y2=y-math.cos(s+y*15)*4
z2=z+math.sin(t+z*9)*4
Z=x2*x2+y2*y2+z2*z2
psize=(Z<16) and (-m)/2+4 or 0
k=8+((m%3)+(x+t)%2)
sx=(t*x-s*n)*w/m+120
sy=(s*x+t*n)*w/m+68
rect(sx,sy,psize,psize,k)
if ((z+t)%8>4) then
rectb(sx,sy,psize,psize,(m/2))
end
end
s=s+t/69t=t-s/54
end

variform_init()
function TIC()
variform()
end