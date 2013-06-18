module GitServer
  REPO_PATH = ENV['GIT_DIR'] || Dir.getwd
  GitRepo = Git.open(REPO_PATH)
  class App < Sinatra::Base
    get '/' do
      commits = GitRepo.log
      haml :index, :locals => {:commits => commits, :repo => GitRepo}
    end

    get '/commit/:sha' do |sha|
      commit = GitRepo.gcommit(sha)
      haml :commit, :layout => false, :locals => {:commit => commit}, :ugly => true
    end

    get '/tree/:sha' do |sha|
      tree = GitRepo.gtree(sha)
      haml :tree, :layout => false, :locals => {:tree => tree}, :ugly => true
    end

    get '/blob/:sha' do |sha|
      blob = GitRepo.gblob(sha)
      @file_type = determine_type(blob, params[:name]) if params[:name]
      haml :blob, :layout => false, :locals => {:blob => blob}, :ugly => true
    end

    get '/diff/:sha1/:sha2' do |sha1, sha2|
      diffs = GitRepo.diff(sha1, sha2)
      haml :diff, :layout => false, :locals => {:diffs => diffs}, :ugly => true
    end

    get '*' do
      haml :'404'
    end

    helpers do
      def data_uri(blob)
        base64 = Base64.encode64(blob.contents).gsub("\n",'')
        mime = MimeMagic.by_magic(blob.contents)
        "data:#{mime};base64,#{base64}"
      end

      def file_type(blob, name)
        determine_type(blob, name)
      end
    end

    private

    def determine_type(blob, name)
      basename, extname = File.basename(name), File.extname(name).downcase
      if %w[.bmp .gif .jpg .jpeg .png].include?(extname)
        :image
      else
        file = Tempfile.new([basename, extname])
        file.write(blob.contents)
        file.close
        File.binary?(file.path) ? :binary : :text
      end
    end
  end
end