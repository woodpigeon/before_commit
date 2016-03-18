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
      current = FileUtils.pwd
      dir_path = Pathname dir
      all_files_in_dir = File.join dir_path, '**', '*'
      
      Dir.glob(all_files_in_dir, include_dotfiles).each do |file|
        next if Dir.exist?(file)
        path = Pathname file
        relative_path = path.relative_path_from(dir_path)
        target = File.expand_path relative_path, current
        copy file, target
      end
    end
    
    def self.include_dotfiles
      File::FNM_DOTMATCH
    end
  end
end