BY_HOURS = Array(0..23).freeze

p 'Selecte Date... (YYYY-MM-DD):'
date = gets
date.chomp!

p 'Enter papertrail token:'
token = gets
token.chomp!

BY_HOURS.each do |hour|
  hour = format('%02d', hour)
  system "curl --no-include -o logs-#{date}-#{hour}.tsv.gz -L -H 'X-Papertrail-Token: #{token}' \
          https://papertrailapp.com/api/v1/archives/#{date}-#{hour}/download"
end
