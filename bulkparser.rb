require './extractor'
require 'json'

@args = Extractor.extract_arguments!

query = @args[:query]
team  = @args[:team]

dates = JSON.parse(@args[:dates])
ids   = JSON.parse(@args[:ids])

dates.each do |date|
  ids.each do |id|
    single_query = query.gsub('%id', id.to_s)

    system("ruby logparser.rb --date=#{date} --index='user-#{id}-team-#{team}' --query='#{single_query}'")
  end
end



