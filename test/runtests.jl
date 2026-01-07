using JuPianoroll
using Test

function run_tests(list)
    for test in list
        include(test)
    end
end

println("Julia version: ", VERSION)

test_suites = [
    ("Utils", ["utils/keys.jl", ])
]

@testset "JuPianoroll.jl" begin
    for ts in eachindex(test_suites)
        name = test_suites[ts][1]
        list = test_suites[ts][2]

        let
            @testset "$name" begin
                run_tests(list)
            end
        end
    end
end
