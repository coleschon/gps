module gps

export Coordinates, validatecoords, dms2rad, rad2dms, ll2cart, cart2ll, abovehorizon, Newton

include("data.jl")
include("prelude.jl")
include("satellite.jl")
include("newton.jl")

end
