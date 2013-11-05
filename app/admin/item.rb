ActiveAdmin.register Item do
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :base_dir
      f.input :description
      f.input :main_image, as: :file, hint: f.template.image_tag(f.object.main_image.url(:medium))
      f.input :order
      f.input :slug
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit(:item => [:name, :base_dir, :description, :main_image, :order, :slug])
    end
  end
end
