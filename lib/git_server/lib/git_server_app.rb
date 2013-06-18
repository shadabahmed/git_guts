require_relative 'git_server'
require_relative 'version'
require 'tempfile'
require 'base64'

module GitServer
  class App
    configure do
      set :root, File.join(File.dirname(__FILE__), '..')
      set :public_folder, File.join(root, 'public')
      set :views, File.join(root, 'views')
      set :environment, :production
      disable :logging, :sessions
    end
  end
end