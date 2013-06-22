module GitGuts
  class Inception < Thor::GitGroup
    desc 'Shows git inception'
    def inception
      1.upto(30) do |level|
        str = "   "*(30-level) + ".git"
        puts level == 29 ? (str + " <--- 2nd Level Gitception").red : str

      end
    end
  end
end


