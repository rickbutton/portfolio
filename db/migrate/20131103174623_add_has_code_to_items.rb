class AddHasCodeToItems < ActiveRecord::Migration
  def change
    add_column :items, :has_code, :boolean, default: true
  end
end
