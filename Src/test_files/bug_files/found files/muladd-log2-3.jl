x = muladd((5270536651468945146),(π),13656)
println(x)
println(x*(10^-19))
println((5270536651468945146*π)+(13656))

x = muladd((33//34),(3.0),(0.5938))
println(x)
println(33//34*3.0+0.5938)

a=0
for i in 1:9999999999999
    global a+=1
end
println(a)