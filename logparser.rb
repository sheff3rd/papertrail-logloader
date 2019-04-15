require 'csv'

BY_HOURS = Array(0..23).freeze

p 'Selecte Date... (YYYY-MM-DD):'
date = gets
date.chomp!

p 'Select parsable string...'
parse = gets
parse.chomp!

found = []

BY_HOURS.each do |hour|
  hour = format('%02d', hour)

  file = File.open("./tmp/logs-#{date}-#{hour}.tsv")
  lines = file.read.split("\n")

  lines.each_with_index do |line, index|
    next unless line =~ /#{Regexp.escape(parse)}/

    found << [
      "logs-#{date}-#{hour}",
      index,
      line
    ]
  end
end

CSV.open("report-#{date}.csv", 'wb') do |csv|
  csv << ['File', 'Line number', 'Content']

  found.each { |line| csv << line }
end
