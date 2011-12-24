module MiniYard
  class Folder
    attr_reader :name, :doc, :cov, :ci
    
    def initialize(path)
      @path = path
      @name = File.basename(path)
      @doc = File.directory?(File.join(path, 'doc')) ? "yes" : "no"
      @cov = File.directory?(File.join(path, 'cov')) ? "yes" : "no"
      @ci = get_ci_url
    end
    
    def get_ci_url
      ci_file = File.join(@path, 'ci.url')
      if File.file?(ci_file)
        File.open(ci_file, 'r'){|f| @ci_file = f.read.chop.strip }
      else
        "no"
      end
    end
    
  end
end
