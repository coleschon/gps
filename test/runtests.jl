using gps
using Test

const pi = gps.pi
const π = gps.pi
@testset "gps.jl" begin
    include("testprelude.jl")
    include("testdata.jl")
end
