module GitGuts
  class Guts < Thor::GitGroup
    desc 'Shows the git guts repo'
    def guts
      system 'clear'
      DATA.each_line do |line|
        line.chomp.red.slow_puts(:delay => 0.005)
      end
    end
  end
end
