require 'git'

module GitGuts
  class Open < Thor::GitGroup
    desc 'Opens a git object'
    argument :sha, :required => true, :banner => '<Object SHA>', :type => :string
    WORKING_DIRECTORY = Dir.getwd
    def open
      begin
        repo = Git.open(WORKING_DIRECTORY)
        puts repo.object(sha).contents
      rescue ArgumentError
        puts "Could open repository. Is it a valid git repository ?"
      rescue Git::GitExecuteError
        puts "Not a valid git object"
      end
    end
  end
end


