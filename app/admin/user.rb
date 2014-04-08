ActiveAdmin.register User do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :email, :reset_password_token, :reset_password_sent_at, :remember_created_at, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :first_name, :last_name, :date_of_birth, :username, :addr_street, :addr_postcode, :addr_city, :phone_number, :id_card_number, :facebook_url, :is_anonymous, :use_own_email, :is_system_admin, :is_person_in_need, :status, :id_card_file_name, :id_card_content_type, :id_card_file_size, :id_card_updated_at, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at, :country, :invitation_token, :invitation_created_at, :invitation_sent_at, :invitation_accepted_at, :invitation_limit, :invited_by_type, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email
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
    column :first_name
    column :last_name
    column :username
    column :email
    #column :encrypted_password
    #column :reset_password_token
    #column :reset_password_sent_at
    #column :remember_created_at
    column :created_at
    column :updated_at
    column :date_of_birth
    column :addr_street
    column :addr_postcode
    column :addr_city
    column :country
    column :phone_number
    column :id_card_number
    column :facebook_url
    #column :id_card_file_name
    #column :id_card_content_type
    #column :id_card_file_size
    #column :id_card_updated_at
    #column :avatar_file_name
    #column :avatar_content_type
    #column :avatar_file_size
    column :is_system_admin
    column :status
    #column :sign_in_count
    column :current_sign_in_at
    column :last_sign_in_at
    column :current_sign_in_ip
    column :last_sign_in_ip
    #column :avatar_updated_at
    #column :invitation_token
    #column :invitation_created_at
    #column :invitation_sent_at
    #column :invitation_accepted_at
    #column :invitation_limit
    #column :invited_by_id
    #column :invited_by_type
    default_actions

  end

  show do |u|
      default_main_content
      attributes_table do
        row :id_card do
          image_tag(u.id_card.url(:thumb))
        end
        row :avatar do
          image_tag(u.avatar.url(:thumb))
        end
      end
    end
end
