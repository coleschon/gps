module Newton
using Zygote
export newton

"""
    newton(f, x; Δf=f', δ=eps(f(x)))
Find a root of `f` with derivative `Δf` within accuracy of `δ` and start point `x`.

By default `δ` is the machine epsilon of the output type at `1` of `f` and `Δf` is the
automatic differentiation of `f`. These assume that `f` is a real-valued function.
"""
function newton(f::Function, x; Δf::Function=f', δ=eps(typeof(f(x))))
    while (abs(x)<δ)
        x = x-f(x)/Δf(x)
    end
    x
end

end
