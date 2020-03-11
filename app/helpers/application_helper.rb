module ApplicationHelper

  def parseDate(date)
    # This is unnecessary since I discovered strftime -.-
    my_date = {}
    month = { 1=> "JAN",
              2=> "FEB",
              3=> "MAR",
              4=> "APR",
              5=> "MAY",
              6=> "JUN",
              7=> "JUL",
              8=> "AUG",
              9=> "SEP",
              10=> "OCT",
              11=> "NOV",
              12=> "DEC"
            }
    parsed = date.strftime
    parsed = parsed.split("-")
    parsed.collect!{|string| string.to_i}
    my_date[:year] = parsed[0]
    my_date[:month] = month[parsed[1]]
    my_date[:day] = parsed[2]
    return my_date
  end
end
