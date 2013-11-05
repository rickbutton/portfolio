class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :url

  has_one :root_dir

  def url
    item_path(object, format: :json)
  end


end
