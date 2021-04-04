@testset "satellites.jl" begin
    using gps.Satellite
    using Zygote
    using ForwardDiff
    using ReverseDiff
    using LinearAlgebra

    # Here we want to make sure that AD has enough accuracy for us,
    # so we walk through an example
    # Consider the function that we wish to find zeros for in ex. 9. In
    # particular for satellite 0 and lamp-post b12:
    tv = 0.0
    sat=satellites[1]
    x=ll2cart(b12...)
    function f(t::Real)::Real
        Δx = Satellite.position(sat,t)-x
        Δx⋅Δx-c^2*(tv-t)^2
    end
    # Now we have two versions of the derivative. First: the general version
    # computed in the handout:
    function Δf(t::Real)::Real
        α=2*π*t/sat.p+sat.θ
        (4*π*(R+sat.h)/sat.p)*((Satellite.position(sat,t)-x)⋅(-sin(α)*sat.u+cos(α)*sat.v)) + 2*c^2(tv-t)
    end

    # Next, ForwardDiff.derivative(f,␢) is the AD derivative.
    # Lets see if they are the same for some real values of t:
    ts = BigFloat.(range(-1000.0, 1000.0, length=500), precision=128)
    #@test all(Δf.(ts) .≈ ForwardDiff.derivative.(f, ts))
    t = BigFloat(10.0, precision=128)
    @test Δf(t) ≈ f'(t) # Zygote.gradient(f, t)[1]
    @test f'(t) ≈ ForwardDiff.derivative(f,t)
end
