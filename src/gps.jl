module gps

export Coordinates, validatecoords, dms2rad, rad2dms, ll2cart, cart2ll, abovehorizon

include("data.jl")
include("prelude.jl")
include("satellites.jl")

end
