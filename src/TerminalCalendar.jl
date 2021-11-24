module TerminalCalendar

using Dates
using PrettyTables

# turn month of `dt` into 5x7 array of dates with missing values
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

function calendar(dt::Date = today())
    calenderized_dt = calendarize(dt)
    mn = monthname(dt)
    yr = year(dt)
    printstyled("\n\n               $mn $yr \n", bold=true)
    pretty_table(
        day.(calenderized_dt),
        header=first.(dayname.(1:7), 3),
        formatters=ft_missing
    )
end

function calendar(
    year::Integer,
    month::Integer
    )
    dt = Date(year, month)
    calendar(dt)
end

function calendar(year::Integer)
    for month in 1:12
        calendar(Date(year, month))
    end
end

export calendar

end
