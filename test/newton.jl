@testset "newton.jl" begin
    using gps.Newton
    # lets find the zero of a simple linear function
    @test newton(x->3.0x-5.0, 0.0) ≈ 5/3
end
