class LocalChildGenerator
  @@ignores = [".", "..", ".git", ".keep", "tmp"]
  def generate(item, full_path)
    entries = Dir.entries(full_path) 
    children = []
    entries.each do |entry|
      next if @@ignores.include? entry
      if File.directory? File.join(full_path, entry)
        children << DirectoryEntry.new(item, File.join(full_path, entry))
      elsif File.file? File.join(full_path, entry)
        children << FileEntry.new(item, File.join(full_path, entry))
      end
    end
    children
  end

  def directory?(full_path)
    File.directory? full_path
  end
end
