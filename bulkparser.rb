require './extractor'

DATES = ['2019-04-10', '2019-04-11'].freeze
IDS   = [40546].freeze

@args = Extractor.extract_arguments!

p @args
query = @args[:query]

DATES.each do |date|
  IDS.each do |id|
    single_query = query.gsub('%id', id.to_s)

    system("ruby logparser.rb --date=#{date} --index='user-#{id}' --query='#{single_query}'")
  end
end



