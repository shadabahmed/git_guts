module GitServer
  REPO_PATH = ENV['GIT_DIR'] || Dir.getwd
  GitRepo = ENV['BARE'] ? Git.bare(REPO_PATH) : Git.open(REPO_PATH)
  class App < Sinatra::Base
    get '/' do
      commits = GitRepo.object('HEAD') && GitRepo.log(100) rescue []
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

    private

    helpers do
      def data_uri(blob)
        base64 = Base64.encode64(blob.contents).gsub("\n",'')
        mime = FileMagic.new(FileMagic::MAGIC_MIME).buffer(blob.contents)
        "data:#{mime};base64,#{base64}"
      end

      def file_type(blob, name)
        determine_type(blob, name)
      end

      def determine_type(blob, name)
        extname = File.extname(name).downcase
        if %w[.bmp .gif .jpg .jpeg .png].include?(extname)
          :image
        else
          case FileMagic.new(FileMagic::MAGIC_MIME).buffer(blob.contents)
            when /image/ then :image
            when /binary|octet/ then :binary
            else :text
          end
        end
      end
    end
  end
end