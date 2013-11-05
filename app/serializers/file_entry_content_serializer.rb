class FileEntryContentSerializer < ActiveModel::Serializer
  attributes :name, :full_path, :content
end
