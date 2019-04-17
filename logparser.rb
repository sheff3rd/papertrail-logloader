require 'csv'
require './extractor'

@args = Extractor.extract_arguments!

date  = @args[:date]
query = @args[:query]
index = @args[:index]

BY_HOURS = Array(0..23).freeze

found = []

BY_HOURS.each do |hour|
  hour = format('%02d', hour)

  file = File.open("./tmp/logs-#{date}-#{hour}.tsv")
  lines = file.read.split("\n")

  lines.each_with_index do |line, index|
    next unless line =~ /#{Regexp.escape(query)}/

    found << [
      "logs-#{date}-#{hour}",
      index,
      line
    ]
  end
end

target_file = if index.nil?
                "./reports/report-#{date}.csv"
              else
                "./reports/report-#{date}-#{index}.csv"
              end

if found.empty?
  p "No matches found for #{target_file}"
else
  CSV.open(target_file, 'wb') do |csv|
    csv << ['File', 'Line number', 'Content']

    found.each { |line| csv << line }
  end
  p "Saved to #{target_file}"
end
