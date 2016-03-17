module BeforeCommit
  module Runner
    def self.run
      FileManager.copy_dir_to_current source_dir
    end
    
    def self.source_dir
      @source_dir ||= File.join gem_root, 'source'
    end
    
    def self.gem_root
      @gem_root ||= File.expand_path '../..', File.dirname(__FILE__)
    end
  end
end
