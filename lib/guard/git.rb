require 'guard'
require 'guard/guard'

module Guard
  class Git < Guard
    VERSION = "0.0.1"

    def start
      run_all if options[:all_on_start]
    end

    def run_all
      run_on_change(Watcher.match_files(self, Dir.glob('*')))
    end

    def run_on_change(paths)
      changed_paths = paths.join(' ')
      puts %Q{Auto committing #{"all files" unless options[:exclusive]} after changes in #{changed_paths}}
      %x{git add -A #{changed_paths if options[:exclusive]} && git commit -m "Autocommit at #{Time.now.strftime("%l:%m%P, %d %h %Y")}"}
    end
  end
end