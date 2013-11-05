class FakeReplaceChildGenerator
  def initialize(children)
    @children = children
  end
  def generate(item, full_path)
    @children
  end
  def directory?(full_path)
    true
  end
end

class FakeChildGenerator
  def generate(item, full_path)
    children = []
    %w(dir1 dir2 dir3).each do |dir|
      sub_children = []
      %w(sf1 sf2 sf3).each do |f|
        sub_children << FileEntry.new(item, File.join(full_path, dir, f), false)
      end
      %w(sd1 sd2 sd3).each do |d|
        sub_children << DirectoryEntry.new(item, File.join(full_path, dir, d), 
                                           FakeReplaceChildGenerator.new([]))
      end
      dir = DirectoryEntry.new(item, File.join(full_path, dir), 
                               FakeReplaceChildGenerator.new(sub_children))
      children << dir
    end
    %w(f1 f2 f3).each do |f|
      children << FileEntry.new(item, File.join(full_path, f), false)
    end
    children
  end
  def directory?(full_path)
    true
  end
end


