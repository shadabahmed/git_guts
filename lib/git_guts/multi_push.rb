require 'git'
require 'net/ssh'

module GitGuts
  class MultiPush < Thor::GitGroup
    WORKING_DIRECTORY = Dir.getwd
    desc 'Creates a remote'
    argument :remotes, :required => true, :banner => '<Remotes> <Branch>', :desc => 'remotes and branches', :type => :array
    def create
      begin
        raise Thor::Error.new("No branch specified".red) if remotes.size < 2
        branch = remotes.pop
        Git.open(WORKING_DIRECTORY)
        remotes.each do |remote|
          puts "Pushing #{branch} to #{remote}"
          puts %x[git push #{remote} #{branch}]
          raise Thor::Error.new "Push to #{remote} failed" if $?.to_i > 0
        end
      rescue ArgumentError
        raise Thor::Error.new "Could open repository. Is it a valid git repository ?"
      end
    end
  end
end
