import LinearAlgebra

"""
   dms2rad(d, m, s)
Given degrees, minutes and seconds of an angle convert to a radian value.

The inverse of `rad2dms`.
"""
function dms2rad(d::Integer, m::Integer=0, s::Real=0)::Real
   if m >= 60
      error("m > 60");
   elseif s >= 60
      error("s > 60");
   end
   (d + (m + s / 60) / 60)*2*π/360
end

"""
   rad2dms(α)
Given a radian value convert to degrees, minutes and seconds.

The inverse of `dms2rad`.
"""
function rad2dms(α::Real)::Tuple{Integer,Integer,Integer}
   α = α*360/(2*π)
   d = Int(α)
   m = Int((α-d)*60)
   s = Int(((α-d)*60-s)*60)
   (d,m,s)
end

# TODO use Givens?
"""
   rot_z(α)
Generates a 3d "roll" rotation matrix about the z axis by `α` radians
"""
rot_z(α::Real)::Matrix{<:Real} = [cos(α) -sin(α) 0; sin(α) cos(α) 0; 0 0 1]

# TODO replace with dat
R = 6.3674445e06
s = 8.616408999999999651e04 

"""
   ll2cart(ψ, λ, h, t=0)
Convert latitude, longitude, height and time to (x,y,z) coordinates
"""
ll2cart(ψ::Real, λ::Real, h::Real, t::Real=0.0)::Vector{Real} = rot_z(2π*t/s)*[cos(ψ)cos(λ),cos(ψ)sin(λ),sin(ψ)].*(R+h)

"""
   cart2ll(coords, t=0)
Convert Cartesian coordinates into latitude, longitude and height

The inverse of `ll2cart`
"""
function cart2ll(coords::Vector{<:Real}, t::Real=0.0)::Tuple{Real,Real,Real}
   # TODO replace with dat
   if length(coords) != 3
      error("Coordinates needs to be a length 3 vector")
   end
   if t != 0.0
      # undo rotation of earth
      coords = rot_z(-2*π*t/s)*coords
   end
   n = LinearAlgebra.norm(coords)
   (atan(coords[3],LinearAlgebra.norm(coords[1:2])),atan(coords[2],coords[1]),n-R)
end
