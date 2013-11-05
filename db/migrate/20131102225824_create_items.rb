class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :base_dir

      t.timestamps
    end
  end
end
