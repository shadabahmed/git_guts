module GitGuts
  class Test < Thor::GitGroup
    desc 'Prints out Hello'

    argument :name, :required => true, :banner => 'Please enter a name', :type => :string
    class_option :verbose, :aliases => '-v'
    class_option :terbose, :aliases => '-t'
    def hi
      puts "Hi #{name} !"
      puts "How are you today?" if options[:verbose]
      puts "I am good" if options[:terbose]
    end

  end
end