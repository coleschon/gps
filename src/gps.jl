module gps

export Coordinates, validatecoords, dms2rad, rad2dms, ll2cart, cart2ll, abovehorizon
#export Newton

#include("data.jl")
include("prelude.jl")
#include("satellites.jl")
#include("newton.jl")

end
