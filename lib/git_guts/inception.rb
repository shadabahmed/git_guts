module GitGuts
  class Inception < Thor::GitGroup
    desc 'Shows git inception'
    def inception
      1.upto(40) do |level|
        str = "   "*(40-level) + ".git"
        puts level == 39 ? (str + " <--- 2nd Level Gitception").red : str

      end
    end
  end
end


