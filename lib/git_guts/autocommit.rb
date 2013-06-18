require 'git'
require 'guard'
require 'guard/git'

module GitGuts
  class Autocommit < Thor::GitGroup
    WORKING_DIRECTORY = Dir.getwd
    desc 'Autocommit if files change'
    argument :files, :required => true, :banner => '<Files To Watch>', :type => :array
    def autocommit
      begin
        Git.open(WORKING_DIRECTORY)
        guard_file = <<-EOF
          guard 'git' do
            watch(%r{^#{files.join('|')}$})
          end
        EOF
        Guard.start(:guardfile_contents => guard_file)
        while Guard.running do
          sleep 0.5
        end
      rescue ArgumentError
        puts "Could open repository. Is it a valid git repository ?"
      end
    end
  end
end