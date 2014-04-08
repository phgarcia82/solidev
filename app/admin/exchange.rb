ActiveAdmin.register Exchange do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :user_id, :organization_id, :person_in_need_id, :is_offer, :is_demand, :title, :quantity, :description, :start, :end, :status_cd, :radius, :picture_file_name, :picture_content_type, :picture_file_size, :picture_updated_at, :created_date, :created_user, :latitude, :longitude, :file_attachment_file_name, :file_attachment_content_type, :file_attachment_file_size, :file_attachment_updated_at
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
    column :is_offer
    column :is_demand
    column :title
    column :quantity
    column :description
    column :created_date
    column "Starting date",:start
    column "Deadline",:end
    column "Status",:status_cd
    column :radius
    column :user_id
    column :created_user
    column :organization_id
    column :person_in_need_id
    column :picture_file_name
    #column :picture_content_type
    column :picture_file_size
    default_actions

  end
end
