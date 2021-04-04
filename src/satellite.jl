using gps
const pi = gps.pi
const π = gps.pi

for line in eachline()
    parsedms(dms) =
        parse(Int,dms[4])*dms2rad(parse.(Int,dms[1:2])...,parse(Float64,dms[3]))
    splitline = split(line)
    t=parse(Float64, splitline[1])
    ψ=parsedms(splitline[2:5])
    λ=parsedms(splitline[6:9])
    h=parse(Float64, splitline[10])
    #println(line, " → ", (t,ψ,λ,h))
end
