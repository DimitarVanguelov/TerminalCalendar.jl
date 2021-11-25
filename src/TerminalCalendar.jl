module TerminalCalendar

using Dates
using PrettyTables


### helper functions ###

# turn month of `dt` into nx7 array of dates with missing values
function calendarize(dt::Date)
    first_day = firstdayofmonth(dt)
    last_day = lastdayofmonth(dt)

    first_missings = fill(missing, dayofweek(first_day) - 1)
    last_missings = fill(missing, 7 - dayofweek(last_day))

    dates = first_day:Day(1):last_day
    padded_dates = vcat(first_missings, dates, last_missings)

    return permutedims(reshape(padded_dates, 7, :))
end


# formatter function to replace missings, thanks to @ronisbr
ft_missing = (v, i, j) -> ismissing(v) ? "" : v


# center month-year header for each monthly calendar
function create_month_year_header(dt::Date, table_str::AbstractString)
    mo = monthname(dt)
    yr = year(dt)
    byte_index = findfirst('\n', table_str)
    table_width = length(table_str, 1, byte_index)
    month_year_width = length(mo) + length(string(yr)) + 1
    front_pad_width = Int(floor((table_width - month_year_width) / 2)) - 1
    front_pad = repeat(' ', front_pad_width)
    return string('\n', front_pad, "$mo $yr", '\n')
end


### exported functions ###

# date type arguments
function calendar(dt::Date = today())
    calenderized_dt = calendarize(dt)

    table_str = pretty_table(
        String,
        day.(calenderized_dt),
        header=first.(dayname.(1:7), 3),
        formatters=ft_missing,
    )

    month_year_header = create_month_year_header(dt, table_str)

    printstyled(month_year_header, bold=true)
    print(table_str)
end

function calendar(dates::Vector{Date})
    for dt in dts
        calendar(dt)
    end
end

function calendar(dts::StepRange{Date, Month})
    for dt in dts
        calendar(dt)
    end
end


# integer type arguments
function calendar(year::Integer, month::Integer)
    dt = Date(year, month)
    calendar(dt)
end

function calendar(year::Integer)
    for month in 1:12
        calendar(Date(year, month))
    end
end

function calendar(years::Vector{Int64})
    for year in years
        calendar(year)
    end
end

function calendar(years::UnitRange{Int64})
    for year in years
        calendar(year)
    end
end

function calendar(years::Vector{Int64}, month::Integer)
    for year in years
        calendar(year, month)
    end
end

function calendar(years::UnitRange{Int64}, month::Integer)
    for year in years
        calendar(year, month)
    end
end

function calendar(year::Integer, months::Vector{Int64})
    for month in months
        calendar(year, month)
    end
end

function calendar(year::Integer, months::UnitRange{Int64})
    for month in months
        calendar(year, month)
    end
end

function calendar(years::Vector{Int64}, months::Vector{Int64})
    for year in years, month in months
        calendar(year, month)
    end
end

function calendar(years::UnitRange{Int64}, months::UnitRange{Int64})
    for year in years, month in months
        calendar(year, month)
    end
end

function calendar(years::Vector{Int64}, months::UnitRange{Int64})
    for year in years, month in months
        calendar(year, month)
    end
end

function calendar(years::UnitRange{Int64}, months::Vector{Int64})
    for year in years, month in months
        calendar(year, month)
    end
end


export calendar

end
