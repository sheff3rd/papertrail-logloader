class Extractor
  def self.extract_arguments!
    args = {}
    ARGV.each do |option|
      split = option.split('=')

      key = split[0].gsub('--', '')
      value = split[1]

      args[key.to_sym] = value
    end

    args
  end
end
