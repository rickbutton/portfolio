require "pathname"

class FileEntry
  include ActiveModel::Serialization
  include Rails.application.routes.url_helpers

  attr_reader :name, :full_path, :item

  def initialize(item, full_path, check_file = true)
    raise "#{full_path} is not a file" unless !check_file || File.file?(full_path)
    @name = Pathname.new(full_path).basename.to_s
    @item = item
    @full_path = full_path
  end

  def type
    :file
  end

  def url
    root = Pathname.new(item.root_dir.full_path)
    relative_path = Pathname.new(full_path).relative_path_from root
    content_item_path(item, relative_path)
  end

  def content
    File.read(full_path)
  end

  def attributes
    {
      type: type,
      name: name,
      full_path: full_path,
      content_url: url
    }
  end

  def as_json(options = nil)
    attributes
  end


end
