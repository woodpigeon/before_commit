require 'fileutils'
class FileManager
  def self.copy(source, target)
    FileUtils.copy(source, target)
  end
end
