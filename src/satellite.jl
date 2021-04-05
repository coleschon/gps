using gps
#using LinearAlgebra
#using gps.Satellite
#const pi = gps.pi
#const π = gps.pi

pi = 0 # pi
π  = 0 # pi
c  = 0 # speed of light, [m/s]
R  = 0 # radius of earth, [m]
s  = 0 # length of a sidereal day, [s]


struct Sat
    u::Coordinates
    v::Coordinates
    periodicity::Real
    altitude::Real
    phase::Real
    Sat(u,v,p,a,θ) = begin
        validatecoords(u,v)
	new(u,v,p,a,θ)
    end
end
satellites = Vector{Sat}(undef,24)
function Base.getproperty(x::Sat, s::Symbol)
    if s===:θ
        getfield(x, :phase)
    elseif s===:h
        getfield(x, :altitude)
    elseif s===:p
        getfield(x, :periodicity)
    else
        getfield(x, s)
    end
end


"""
    read_data(data)
"""
function read_data(args)
    if length(args) < 1
        println(stderr, "Please enter data file!") # TODO - error printout formatting
	exit(1);
    end
    open(args[1]) do f
        line = 1
	satellite = 0
	setprecision(256)
	while ! eof(f)
	    str = readline(f)
	    str = lstrip(str, [' '])
	    str = split(str)

	    if line < 5
	        if line == 1
		    pi = parse(BigFloat, str[1])
		    π = parse(BigFloat, str[1])
		elseif line == 2
		    c = parse(BigFloat, str[1])
		elseif line == 3
		    R = parse(BigFloat, str[1])
		else
		    s = parse(BigFloat, str[1])
		end
		#println(str[1])
		#println(parse(BigFloat, str[1]))
		line +=1
	    else
		u1 = parse(BigFloat, str[1])
		#println(str[1])
		#println(parse(BigFloat, str[1]))
		str = readline(f)
		str = lstrip(str, [' '])
		str = split(str)
		u2 = parse(BigFloat, str[1])
		#println(str[1])
		#println(parse(BigFloat, str[1]))
		str = readline(f)
		str = lstrip(str, [' '])
		str = split(str)
		u3 = parse(BigFloat, str[1])
		#println(str[1])
		#println(parse(BigFloat, str[1]))
		str = readline(f)
		str = lstrip(str, [' '])
		str = split(str)
		v1 = parse(BigFloat, str[1])
		#println(str[1])
		#println(parse(BigFloat, str[1]))
		str = readline(f)
		str = lstrip(str, [' '])
		str = split(str)
		v2 = parse(BigFloat, str[1])
		#println(str[1])
		#println(parse(BigFloat, str[1]))
		str = readline(f)
		str = lstrip(str, [' '])
		str = split(str)
		v3 = parse(BigFloat, str[1])
		#println(str[1])
		#println(parse(BigFloat, str[1]))
		str = readline(f)
		str = lstrip(str, [' '])
		str = split(str)
		periodicity = parse(BigFloat, str[1])
		#println(str[1])
		#println(parse(BigFloat, str[1]))
		str = readline(f)
		str = lstrip(str, [' '])
		str = split(str)
		altitude = parse(BigFloat, str[1])
		#println(str[1])
		#println(parse(BigFloat, str[1]))
		str = readline(f)
		str = lstrip(str, [' '])
		str = split(str)
		phase = parse(BigFloat, str[1])
		#println(str[1])
		#println(parse(BigFloat, str[1]))

                u = [u1, u2, u3]
		v = [v1, v2, v3]
                sat = Sat(u,v,periodicity,altitude,phase)		
		satellites[satellite+1] = sat
		satellite +=1
            end
	end
    end
end

read_data(ARGS)
export pi, π, c, R, s, satellites
exit()



"""
    satloc(sat, ℓ, t)
Find the cartesian coordinates and time of the satellite such that its
broadcast at that location will reach coordinates `ℓ` at time `t`.
"""
function satloc(sat::Sat, xv::Coordinates, tv::Real)::Tuple{Coordinates,<:Real}
    # This function should have a root at the time we desire
    function f(t::Real)::Real
        Δx = Satellite.position(sat,t)-xv
        Δx⋅Δx-c^2*(tv-t)^2
    end
    # We start our search at the current vehicle time, assuming it will be rather close
    # Furthermore our δ must be less than .01m/c in order to have 1cm accuracy
    t = Newton.newton(f, tv, δ=BigFloat(.01)/c)
    Satellite.position(sat, t), t
end

"""
    overhorizon(x,s)
returns true iff `s` is over the horizon of `x`.
"""
function overhorizon(xv::Coordinates, s::Coordinates)::Bool = xv⋅(xv-s)>0

setprecision(128)

for line in eachline()
    parsedms(dms)::BigFloat =
        parse(Int,dms[4])*dms2rad(parse.(Int,dms[1:2])...,parse(BigFloat,dms[3]))
    splitline = split(line)
    t=parse(BigFloat, splitline[1])
    ψ=parsedms(splitline[2:5])
    λ=parsedms(splitline[6:9])
    h=parse(BigFloat, splitline[10])
    #println(line, " → ", (t,ψ,λ,h))
    ℓ = ll2cart(ψ,λ,h,t)
    for (is, sat) in enumerate(Satellite.satellites)
        xs, ts = satloc(sat, ℓ, t)
        if overhorizon(ℓ, xs)
            println(is, ' ', ts, ' ', xs) 
        end
    end
end
