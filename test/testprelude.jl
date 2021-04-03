@testset "prelude.jl" begin
    @test_throws DimensionMismatch validatecoords([1])
    @test_throws DimensionMismatch validatecoords([1,2,3,4])

    @test dms2rad(90) ≈ π/2
    @test dms2rad(180,0,0) ≈ pi
    @test abs(dms2rad(90,0,1) - π/2) < 1e-5
    @test abs(dms2rad(rad2dms(2*π/3)...)- 2*π/3) < 1e-5
    @test all(rad2dms(dms2rad(3,0,12)) .≈ (3,0,12))
    # lamp post b12
    b12 = (dms2rad(40,45,55.0),-dms2rad(111,50,58.0), 1372.)
    # at time t=0 we should be able to convert to cartesian coordinates and back
    @test all(cart2ll(ll2cart(b12...)) .≈ b12)
    # likewise at noon
    @test all(cart2ll(ll2cart(b12..., 43200), 43200) .≈ b12)
    # but it should be in a different location at noon
    @test !all(ll2cart(b12...) .≈ ll2cart(b12..., 43200))
    # and at the same location at 1 sidereal day
    @test all(ll2cart(b12...) .≈ ll2cart(b12...,8.616408999999999651e04))
end
