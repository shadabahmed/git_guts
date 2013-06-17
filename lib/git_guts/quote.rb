module GitGuts
  class Quote < Thor::GitGroup
    desc 'Quotes a person'
    argument :name, :required => true, :banner => '<PERSON NAME>', :type => :string

    def about
      if name.downcase != 'linus'
        "\nSorry, I do not know this guy\n".red.slow_puts
      else
        DATA.each_line.each_with_index do |msg, i|
          if i == 4
            msg.chomp.random_color.slow_puts :delay => 0.015
          else
            msg.chomp.random_color.slow_puts
          end
        end
      end
    end
  end
end
