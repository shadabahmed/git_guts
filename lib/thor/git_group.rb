class Thor
  class GitGroup < Group
    BASENAME = 'git'
    def self.basename
      BASENAME
    end

    def self.namespace
      name.split('::').last.downcase
    end
  end
end