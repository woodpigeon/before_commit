require 'fileutils'
require 'pathname'
module BeforeCommit
  module FileManager
    def self.copy(source, target)
      dir = File.dirname(target)
      FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
      FileUtils.cp source, target
    end
    
    def self.copy_dir_to_current(dir)
      dir_path = Pathname dir
      all_files_in_dir = File.join dir_path, '**', '*'
      count = 0
      
      Dir.glob(all_files_in_dir, include_dotfiles).each do |file|
        path = Pathname file
        relative_path = path.relative_path_from(dir_path)
        target = File.expand_path relative_path, current
        if Dir.exist?(file)
          unless dir == file || target == current || ends_with_a_dot?(file)
            FileUtils.rm_rf target
          end
        else
          copy file, target
          count += 1
        end
      end
      "#{count} files copied to current location"
    end
    
    def self.include_dotfiles
      File::FNM_DOTMATCH
    end
    
    def self.current
      @current ||= FileUtils.pwd
    end
    
    def self.ends_with_a_dot?(file)
      /\.$/ =~ file
    end
  end
end