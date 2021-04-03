@testset "prelude.jl" begin
    @test_throws DimensionMismatch validatecoords([1])
    @test_throws DimensionMismatch validatecoords([1,2,3,4])

    @test dms2rad(90) ≈ pi/2
    @test dms2rad(180,0,0) ≈ pi
    @test abs(dms2rad(90,0,1) - pi/2) < 1e-5
end
