class String
  ColorMap = {:default => 39, :cyan => 36, :red => 31, :green => 32, :blue => 34, :magent => 35, :yellow => 33, :white => 37}
  Colors = ColorMap.keys

  # colorization
  def colorize(color_code)
    empty? ?  self :  "\e[#{color_code}m#{self}\e[0m"
  end
  
  ColorMap.each do |name, code|
    define_method(name) do
      colorize(code)
    end
  end

  def random_color
    self.send(Colors[rand(Colors.length)])
  end
  
  def slow_puts(opts = {})
    opts[:delay] = 0.02 unless opts[:delay]
    opts[:newline] = true if opts[:newline].nil?
    self.each_char do |x|
      print x
      STDOUT.flush
      sleep opts[:delay]
    end
    puts if opts[:newline]
  end
end

