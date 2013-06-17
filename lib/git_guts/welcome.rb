module GitGuts
  class Welcome < Thor::GitGroup
    desc 'Gives a big warm welcome'
    def welcome
      system 'clear'
      ask "Did you reduce the font size ? It's really BIGGGGGGGGGGGG".random_color
      DATA.each_line do |line|
        line.chomp.blue.slow_puts(:delay => 0.0001)
      end
    end
  end
end