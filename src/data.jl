export DATA_FILE
const DATA_FILE="data.dat"
open(DATA_FILE) do f
    for (n, l) in  enumerate(eachline(f))
        s = split(l)[1]
        if n < 5
            if n == 1
                quote 
                    export pi, π
                    const pi = BigFloat($s)
                    const π = BigFloat($s)
                end |> eval
            elseif n == 2
                quote 
                    export c
                    const c = BigFloat($s)
                end |> eval
            elseif n == 3
                quote 
                    export R
                    const R = BigFloat($s)
                end |> eval
            else
                quote 
                    export s
                    const s = BigFloat($s)
                end |> eval
            end
        else
            break
        end
    end
end
