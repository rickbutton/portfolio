class Item < ActiveRecord::Base

  validates_presence_of :name, :base_dir, :description, :slug
  
  has_attached_file :main_image, 
    :styles => { :large => "800x600", :medium => "400x300", :small => "200x150" },
    :default_url => "http://placehold.it/800x600"

  def root_dir
    @root_dir ||= DirectoryEntry.new(self, base_dir)
  end

  def to_param
    slug
  end

end
