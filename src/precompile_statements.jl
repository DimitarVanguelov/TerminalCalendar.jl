
# no kwargs
precompile(calendar, ())
precompile(calendar, (Date, ))

precompile(calendar, (Vector{Date}, ))
precompile(calendar, (StepRange{Date, Month}, ))

precompile(calendar, (Int, ))
precompile(calendar, (Int, Int))

precompile(calendar, (Vector{Int64}, Int))
precompile(calendar, (UnitRange{Int64}, Int))
precompile(calendar, (StepRange{Int64}, Int))

precompile(calendar, (Int, Vector{Int64}))
precompile(calendar, (Int, UnitRange{Int64}))
precompile(calendar, (Int, StepRange{Int64}))

precompile(calendar, (Vector{Int64}, Vector{Int64}))
precompile(calendar, (Vector{Int64}, UnitRange{Int64}))
precompile(calendar, (Vector{Int64}, StepRange{Int64}))

precompile(calendar, (UnitRange{Int64}, Vector{Int64}))
precompile(calendar, (UnitRange{Int64}, UnitRange{Int64}))
precompile(calendar, (UnitRange{Int64}, StepRange{Int64}))

precompile(calendar, (StepRange{Int64}, Vector{Int64}))
precompile(calendar, (StepRange{Int64}, UnitRange{Int64}))
precompile(calendar, (StepRange{Int64}, StepRange{Int64}))

# with kwargs
precompile(calendar, (TextFormat,))
precompile(calendar, (Date, TextFormat))

precompile(calendar, (Vector{Date}, TextFormat))
precompile(calendar, (StepRange{Date, Month}, TextFormat))

precompile(calendar, (Int, TextFormat))
precompile(calendar, (Int, Int, TextFormat))

precompile(calendar, (Vector{Int64}, Int, TextFormat))
precompile(calendar, (UnitRange{Int64}, Int, TextFormat))
precompile(calendar, (StepRange{Int64}, Int, TextFormat))

precompile(calendar, (Int, Vector{Int64}, TextFormat))
precompile(calendar, (Int, UnitRange{Int64}, TextFormat))
precompile(calendar, (Int, StepRange{Int64}, TextFormat))

precompile(calendar, (Vector{Int64}, Vector{Int64}, TextFormat))
precompile(calendar, (Vector{Int64}, UnitRange{Int64}, TextFormat))
precompile(calendar, (Vector{Int64}, StepRange{Int64}, TextFormat))

precompile(calendar, (UnitRange{Int64}, Vector{Int64}, TextFormat))
precompile(calendar, (UnitRange{Int64}, UnitRange{Int64}, TextFormat))
precompile(calendar, (UnitRange{Int64}, StepRange{Int64}, TextFormat))

precompile(calendar, (StepRange{Int64}, Vector{Int64}, TextFormat))
precompile(calendar, (StepRange{Int64}, UnitRange{Int64}, TextFormat))
precompile(calendar, (StepRange{Int64}, StepRange{Int64}, TextFormat))