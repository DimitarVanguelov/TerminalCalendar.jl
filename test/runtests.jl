using TerminalCalendar
using Test
using Dates

@testset "TerminalCalendar.jl" begin
    feb2021 = Date(2021, 2)

    feb2021_auto = TerminalCalendar.calendarize(feb2021)
    # feb2021_manual = Matrix{Union{Missing, Date}}()
    feb_range = Date(2021, 2, 1):Day(1):Date(2021, 2, 28)
    feb_matrix = permutedims(reshape(feb_range, 7, :))

    @test feb2021_auto == feb_matrix
end
