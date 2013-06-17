module GitGuts
  class About < Thor::GitGroup
    desc 'Describe the person'
    argument :name, :required => true, :banner => '<PERSON NAME>', :type => :string

    def about
      if name.downcase != 'shadab'
        "\nSorry, I do not know this guy\n".red.slow_puts
      else
        DATA.each_line.each do |msg|
          msg.chomp.random_color.slow_puts
        end
        "\nGeography geek - ".random_color.slow_puts(:newline => false)
        sleep 1
        "Infact claims, that he can name and place all countries on the African continent\n".random_color.slow_puts
      end
    end

  end
end