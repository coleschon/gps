readInt() :: Int = parse(Int,readline() |> chomp)
norm(x :: Vector{Int}) :: Float64 = x.^2 |> sum |> sqrt

n = readInt()
x = [readInt() for i in 1:n]
println(norm(x))
