using gps
using Test

const pi = gps.pi
const π = gps.pi
# lamp post b12
const b12 = (dms2rad(40,45,55.0),-dms2rad(111,50,58.0), 1372.)
@testset "gps.jl" begin
    include("prelude.jl")
    include("satellites.jl")
    include("newton.jl")
end
