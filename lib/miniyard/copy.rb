module MiniYard
  class Copy
    
    def initialize(options)
      verify_opts(options)
      @options = options
    end
    
    def run
      FileUtils.mkdir_p(folder_path) unless File.directory?(folder_path)
      
      if @options[:doc]
        $stdout.puts('Copying docs from %s to %s' % [doc_source_path, doc_dest_path])
        FileUtils.rm_rf(doc_dest_path) if File.directory?(doc_dest_path)
        FileUtils.cp_r(doc_source_path, doc_dest_path)
      end
      
      if @options[:cov]
        $stdout.puts('Copying coverage from %s to %s' % [cov_source_path, cov_dest_path])
        FileUtils.rm_rf(cov_dest_path) if File.directory?(doc_dest_path)
        FileUtils.cp_r(cov_source_path, cov_dest_path)
      end
    end
    
    def verify_opts(options)
      raise 'Root directory %s does not exist' % options[:root] unless File.directory?(options[:root])
      raise 'Doc source directory %s does not exist' % doc_source_path if options[:doc] && !File.directory?(options[:doc])
      raise 'Coverage source directory %s does not exist' % cov_source_path if options[:cov] && !File.directory?(options[:cov])
      raise 'Name must be present' % options[:name] unless options[:name]
    end
    
    def doc_source_path
      File.expand_path(@options[:doc])
    end
    
    def cov_source_path
      File.expand_path(@options[:cov])
    end
    
    def doc_dest_path
      File.join(folder_path, 'doc')
    end
    
    def cov_dest_path
      File.join(folder_path, 'cov')
    end
    
    def folder_path
      File.join(root_path, @options[:name])
    end
    
    def root_path
      File.expand_path(@options[:root])
    end
    
  end
end
