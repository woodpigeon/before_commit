require 'fileutils'
require 'pathname'
module BeforeCommit
  class FileManager
    def self.copy(source, target)
      dir = File.dirname(target)
      FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
      FileUtils.cp source, target
    end
    
    def self.copy_dir_to_current(dir)
      new(dir).copy_content_to_current
    end
    
    def self.current
      @current ||= FileUtils.pwd
    end
    
    attr_reader :dir
    
    def initialize(dir)
      @dir = dir
    end
    
    def copy_content_to_current 
      count = 0    
      Dir.glob(all_files_in_dir, include_dotfiles).each do |file|
        path = Pathname file
        relative_path = path.relative_path_from(dir_path)
        target = File.expand_path relative_path, current
        if Dir.exist?(file)
          unless dir == file || target == current || ends_with_a_dot?(file)
            # Assumes directory will be listed first and removes it before
            # following files are copied into location.
            # Note `copy` will recreate the directory
            FileUtils.rm_rf target
          end
        else
          self.class.copy file, target
          count += 1
        end
      end
      "#{count} files copied to current location"
    end
    
    def dir_path
      @dir_path ||= Pathname dir
    end
    
    def current
      self.class.current
    end
    
    def all_files_in_dir
      File.join dir_path, '**', '*'
    end
    
    def include_dotfiles
      File::FNM_DOTMATCH
    end
    
    def ends_with_a_dot?(file)
      /\.$/ =~ file
    end
  end
end