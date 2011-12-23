require "miniyard/version"
require 'fileutils'

module MiniYard
  class Generate
    
    def initialize(root)
      raise 'Unable to generate MiniYard at path %s: not a directory' % path unless File.directory?(root)
      @root = File.expand_path(root)
    end
    
    def run
      FileUtils.rm(index_file) if index_exists?
      output = haml_render(index_template)
      write_file(index_file, output)
      ensure_bootstrap_exists
    end
    
    def folders
      @folders ||= Dir[File.join(@root, '*')].sort.select{|n| File.directory?(n) }.map{|n| File.basename(n) }
    end
    
    def index_template
      haml_template("index")
    end
    
    def index_file
      File.join(@root, 'index.html')
    end
    
    def index_exists?
      File.exist?(index_file)
    end
    
    def haml_template(tpl_name)
      File.expand_path("../templates/#{tpl_name}.haml", File.expand_path(__FILE__))
    end
    
    def haml_render(file)
      contents = File.read(file)
      Haml::Engine.new(contents, {
        filename: file,
        format: :html5,
        attr_wrapper: '"'
      }).render(self)
    end
    
    def write_file(file, contents)
      File.open(file, 'w+') do |f|
        f.write(contents)
      end
    end
    
    def bootstrap_version
      "1.4.0"
    end
    
    def bootstrap_file
      File.join(@root, "bootstrap.#{bootstrap_version}.min.css")
    end
    
    def ensure_bootstrap_exists
      unless File.exist?(bootstrap_file)
        local_bootstrap = File.expand_path("../templates/bootstrap.#{bootstrap_version}.min.css", File.expand_path(__FILE__))
        FileUtils.cp(local_bootstrap, bootstrap_file)
      end
    end
    
  end
end
