require 'chilkat'

BY_HOURS = Array(0..23).freeze

p 'Selecte Date... (YYYY-MM-DD):'
date = gets
date.chomp!

p 'Enter papertrail token:'
token = gets
token.chomp!

gzip = Chilkat::CkGzip.new()
gzip.UnlockComponent('unlock')

BY_HOURS.each do |hour|
  hour = format('%02d', hour)
  system "curl --no-include -o ./tmp/logs-#{date}-#{hour}.tsv.gz -L -H 'X-Papertrail-Token: #{token}' \
          https://papertrailapp.com/api/v1/archives/#{date}-#{hour}/download"

  success = gzip.UncompressFile("./tmp/logs-#{date}-#{hour}.tsv.gz", "./tmp/logs-#{date}-#{hour}.tsv")

  p success ? 'Success' : 'Failure'
end
