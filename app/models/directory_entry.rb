require "pathname"

class DirectoryEntry
  include ActiveModel::Serialization
  include Rails.application.routes.url_helpers


  attr_reader :name, :full_path, :children, :item

  @@ignores = [".", "..", ".git", ".keep", "tmp"]

  def initialize(item = nil, full_path = nil, generator = LocalChildGenerator.new)
    raise "#{full_path} is not a directory" unless generator.directory? full_path
    @item = item
    @name = Pathname.new(full_path).basename.to_s
    @full_path = full_path
    @children = generator.generate(item, full_path)
  end

  def find(path)
    chunks = path.split(File::SEPARATOR)
    children.each do |child|
      if child.type == :directory
        if chunks.first == child.name
          if chunks.size == 1
            return child
          else
            c = child.find File.join(chunks[1..chunks.size])
            return c if c
          end
        end
      elsif child.type == :file
        if chunks.first == child.name
          return child
        end
      end
    end
    nil
  end

  def type
    :directory
  end

  def url
    root = Pathname.new(item.root_dir.full_path)
    relative_path = Pathname.new(full_path).relative_path_from root
    directory_item_path(item, relative_path)
  end


  def attributes
    {
      type: type,
      name: name,
      full_path: full_path,
      url: url,
      children: children
    }
  end

  def as_json(options = nil)
    attributes
  end
end
