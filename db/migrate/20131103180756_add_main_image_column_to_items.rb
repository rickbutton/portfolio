class AddMainImageColumnToItems < ActiveRecord::Migration
  def up
    add_attachment :items, :main_image
  end
  def down
    remove_attachment :items, :main_image
  end
end
