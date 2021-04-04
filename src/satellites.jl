module Satellite
using gps
const π = gps.π

struct Sat
    u::Coordinates
    v::Coordinates
    periodicity::Real
    altitude::Real
    phase::Real
    Sat(u,v,p,a,θ) = begin
        validatecoords(u,v)
        new(u,v,p,a,θ)
    end
end
# add some nice tersity to access
function Base.getproperty(x::Sat, s::Symbol)
    if s===:θ
        getfield(x, :phase)
    elseif s===:h
        getfield(x, :altitude)
    elseif s===:p
        getfield(x, :periodicity)
    else 
        getfield(x, s)
    end
end

#Sat(u::Coordinates,v::Coordinates,p::T,a::T, θ::T) where {T<:Real} = Sat{T}(u,v,p,a,θ)

# we really shouldn't be hardcoding these
const s0  = Sat([ s0_u1,  s0_u2,  s0_u3], [ s0_v1,  s0_v2,  s0_v3],  s0_per,  s0_alt,  s0_pha)
const s1  = Sat([ s1_u1,  s1_u2,  s1_u3], [ s1_v1,  s1_v2,  s1_v3],  s1_per,  s1_alt,  s1_pha)
const s2  = Sat([ s2_u1,  s2_u2,  s2_u3], [ s2_v1,  s2_v2,  s2_v3],  s2_per,  s2_alt,  s2_pha)
const s3  = Sat([ s3_u1,  s3_u2,  s3_u3], [ s3_v1,  s3_v2,  s3_v3],  s3_per,  s3_alt,  s3_pha)
const s4  = Sat([ s4_u1,  s4_u2,  s4_u3], [ s4_v1,  s4_v2,  s4_v3],  s4_per,  s4_alt,  s4_pha)
const s5  = Sat([ s5_u1,  s5_u2,  s5_u3], [ s5_v1,  s5_v2,  s5_v3],  s5_per,  s5_alt,  s5_pha)
const s6  = Sat([ s6_u1,  s6_u2,  s6_u3], [ s6_v1,  s6_v2,  s6_v3],  s6_per,  s6_alt,  s6_pha)
const s7  = Sat([ s7_u1,  s7_u2,  s7_u3], [ s7_v1,  s7_v2,  s7_v3],  s7_per,  s7_alt,  s7_pha)
const s8  = Sat([ s8_u1,  s8_u2,  s8_u3], [ s8_v1,  s8_v2,  s8_v3],  s8_per,  s8_alt,  s8_pha)
const s9  = Sat([ s9_u1,  s9_u2,  s9_u3], [ s9_v1,  s9_v2,  s9_v3],  s9_per,  s9_alt,  s9_pha)
const s10 = Sat([s10_u1, s10_u2, s10_u3], [s10_v1, s10_v2, s10_v3], s10_per, s10_alt, s10_pha)
const s11 = Sat([s11_u1, s11_u2, s11_u3], [s11_v1, s11_v2, s11_v3], s11_per, s11_alt, s11_pha)
const s12 = Sat([s12_u1, s12_u2, s12_u3], [s12_v1, s12_v2, s12_v3], s12_per, s12_alt, s12_pha)
const s13 = Sat([s13_u1, s13_u2, s13_u3], [s13_v1, s13_v2, s13_v3], s13_per, s13_alt, s13_pha)
const s14 = Sat([s14_u1, s14_u2, s14_u3], [s14_v1, s14_v2, s14_v3], s14_per, s14_alt, s14_pha)
const s15 = Sat([s15_u1, s15_u2, s15_u3], [s15_v1, s15_v2, s15_v3], s15_per, s15_alt, s15_pha)
const s16 = Sat([s16_u1, s16_u2, s16_u3], [s16_v1, s16_v2, s16_v3], s16_per, s16_alt, s16_pha)
const s17 = Sat([s17_u1, s17_u2, s17_u3], [s17_v1, s17_v2, s17_v3], s17_per, s17_alt, s17_pha)
const s18 = Sat([s18_u1, s18_u2, s18_u3], [s18_v1, s18_v2, s18_v3], s18_per, s18_alt, s18_pha)
const s19 = Sat([s19_u1, s19_u2, s19_u3], [s19_v1, s19_v2, s19_v3], s19_per, s19_alt, s19_pha)
const s20 = Sat([s20_u1, s20_u2, s20_u3], [s20_v1, s20_v2, s20_v3], s20_per, s20_alt, s20_pha)
const s21 = Sat([s21_u1, s21_u2, s21_u3], [s21_v1, s21_v2, s21_v3], s21_per, s21_alt, s21_pha)
const s22 = Sat([s22_u1, s22_u2, s22_u3], [s22_v1, s22_v2, s22_v3], s22_per, s22_alt, s22_pha)
const s23 = Sat([s23_u1, s23_u2, s23_u3], [s23_v1, s23_v2, s23_v3], s23_per, s23_alt, s23_pha)


export Sat, satellites, position

const satellites = [s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23]

"""
    positions(s, t)
Returns the position of the satellite `s` at time `t`.
"""
function position(s::Sat, t::Real)::Coordinates
    α=2*π*t/s.p+s.θ
    (R+s.h)*(cos(α)*s.u+sin(α)*s.v)
end

end
