ActiveAdmin.register Organization do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :name, :email, :addr_street, :addr_postcode, :addr_city, :phone_number, :vat_number, :site_url, :facebook_url, :description, :use_own_email, :logo_file_name, :logo_content_type, :logo_file_size, :logo_updated_at
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  index do
    column :id
    column :name
    column :description
    column :addr_street
    column :addr_postcode
    column :addr_city
    #column :addr_country
    column :email
    column :phone_number
    column :vat_number
    column :site_url
    column :facebook_url
    column :created_at
    column :updated_at
    column :logo_file_name
    column :logo_content_type
    column :logo_file_size
    column :logo_updated_at
    column :use_own_email
    default_actions

  end

   show do |o|
     default_main_content
     attributes_table do
       row :logo do
         image_tag(o.logo.url(:thumb))
       end
     end
   end
end
