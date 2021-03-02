norm(x) = x.^2 |> sum |> sqrt

n = parse(Int, readline() |> chomp)
x = Vector{Int}()
while length(x) < n
    append!(x, parse.(Int, split(readline(), r" |,")))
end
if length(x) > n
    println("Too many numbers input")
else
    println(norm(x))
end
