module GitGuts
  class Guts < Thor::GitGroup
    desc 'Shows the git guts repo'
    def welcome
      DATA.each_line do |line|
        line.chomp.slow_puts(:delay => 0.001)
      end
    end
  end
end
