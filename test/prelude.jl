@testset "prelude.jl" begin
    @test_throws DimensionMismatch validatecoords([1])
    @test validatecoords([1,2,3]) === nothing
    @test_throws DimensionMismatch validatecoords([1,2,3,4])

    @test dms2rad(90) ≈ π/2
    @test dms2rad(180,0,0) ≈ pi
    @test dms2rad(90,0,1) ≈ π/2 atol=1e-5
    @test dms2rad(rad2dms(2*π/3)...)≈ 2*π/3 atol=1e-5
    # property we'd like. ∀x=(d,m,s) we want all(rad2dms(dms2rad(x...)) .≈ x)
    @test all(isapprox.(rad2dms(dms2rad(3,0,12)), (3,0,12.0), atol=1e-5))
    # at time t=0 we should be able to convert to cartesian coordinates and back
    # property we'd like. ∀x=(ψ,λ,h),t we want all(cart2ll(ll2cart(x...,t),t) .≈ x)
    @test all(isapprox.(cart2ll(ll2cart(b12...)), b12, atol=1e-10))
    # likewise at noon
    @test all(isapprox.(cart2ll(ll2cart(b12..., s/2), s/2), b12, atol=1e-10))
    # but it should be in a different location at noon
    @test !all(ll2cart(b12...) .≈ ll2cart(b12..., s/2))
    # and at the same location at 1 sidereal day
    # XXX SOME VERY WEIRD ERROR ACCUMULATION IS HAPPENING HERE
    # for some reason this test passes with only 1e-8 accuracy even though we
    # have 14SF for all constants.
    @test all(isapprox.(ll2cart(b12...), ll2cart(b12...,s), atol=1e-8))
end
