class AddSlugColumnToItems < ActiveRecord::Migration
  def change
    add_column :items, :slug, :string
  end
end
