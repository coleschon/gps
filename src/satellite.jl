module Satellite
using gps
const π = gps.π

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
# add some nice tersity to access
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

open(DATA_FILE) do f
    lines = map(s -> :(BigFloat($(split(s)[1]))), readlines(f))
    sats=[]
    for i in 5:9:length(lines)
        ex = :(Sat([$(lines[i:i+2]...)],
                   [$(lines[i+3:i+5]...)],
                   $(lines[i+6]),
                   $(lines[i+7]),
                   $(lines[i+8])))
        push!(sats, ex)
    end
    eval(:(const satellites = [$(sats...)]))
end

export Sat, satellites, position

"""
    positions(s, t)
Returns the position of the satellite `s` at time `t`.
"""
function position(s::Sat, t::Real)::Coordinates
    α=2*π*t/s.p+s.θ
    (R+s.h)*(cos(α)*s.u+sin(α)*s.v)
end

end
