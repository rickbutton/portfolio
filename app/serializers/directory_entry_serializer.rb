require "pathname"

class DirectoryEntrySerializer < ActiveModel::Serializer
  attributes :type, :name, :full_path, :name, :url, :children

    
end
