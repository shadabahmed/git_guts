module GitGuts
  class Map < Thor::GitGroup
    argument :country, :required => true
    class_option :full, :aliases => '-f'

    desc 'Shows a map'
    def map
      if country.downcase != 'africa'
        "\nMap for #{ARGV[0]} does not exist\n".red.slow_puts
      else
        type = options[:full] ? 'fullmap' : 'map'
        file_path = File.expand_path("../../../bin/support/#{country}-#{type}.gif", __FILE__)
        `open file://#{file_path}`
      end
    end
  end
end


