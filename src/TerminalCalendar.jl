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
function calendar(dt::Date = today(); tf=tf_unicode)
    calenderized_dt = calendarize(dt)

    table_str = pretty_table(
        String,
        day.(calenderized_dt),
        header=first.(dayname.(1:7), 3),
        formatters=ft_missing,
        tf=tf,
    )

    month_year_header = create_month_year_header(dt, table_str)

    printstyled(month_year_header, bold=true)
    print(table_str)
end

function calendar(dts::Union{Vector{Date}, StepRange{Date, Month}}; tf=tf_unicode)
    for dt in dts
        calendar(dt; tf=tf)
    end
end

# function calendar(dts::StepRange{Date, Month}; tf=tf_unicode)
#     for dt in dts
#         calendar(dt; tf=tf)
#     end
# end


# integer type arguments
function calendar(year::Integer, month::Integer; tf=tf_unicode)
    dt = Date(year, month)
    calendar(dt; tf=tf)
end

function calendar(year::Integer; tf=tf_unicode)
    for month in 1:12
        calendar(Date(year, month); tf=tf)
    end
end

function calendar(years::Union{Vector{Int64}, UnitRange{Int64}}; tf=tf_unicode)
    for year in years
        calendar(year; tf=tf)
    end
end

function calendar(years::Union{Vector{Int64}, UnitRange{Int64}}, month::Integer; tf=tf_unicode)
    for year in years
        calendar(year, month; tf=tf)
    end
end

function calendar(year::Integer, months::Union{Vector{Int64}, UnitRange{Int64}}; tf=tf_unicode)
    for month in months
        calendar(year, month; tf=tf)
    end
end

function calendar(years::Union{Vector{Int64}, UnitRange{Int64}}, months::Union{Vector{Int64}, UnitRange{Int64}}; tf=tf_unicode)
    for year in years, month in months
        calendar(year, month; tf=tf)
    end
end


export calendar

# re-export table formatting from PrettyTables.jl
export tf_ascii_dots,
    tf_ascii_rounded,
    tf_borderless,
    tf_compact,
    tf_markdown,
    tf_matrix,
    tf_mysql,
    tf_simple,
    tf_unicode,
    tf_unicode_rounded

end
