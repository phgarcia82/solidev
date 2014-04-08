ActiveAdmin.register Proposal do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :exchange_id, :user_id, :organization_id, :person_in_need_id, :description, :status_cd, :proposer_rating, :proposer_msg, :owner_rating, :owner_msg, :is_visible
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
    column :description
    column "Status",:status_cd
    column "Exchange id",:exchange_id
    column "User id",:user_id
    column "Organization id",:organization_id
    column "Person in need id",:person_in_need_id
    column "Rating of the exchanger",:proposer_rating
    column "Exchanger message",:proposer_msg
    column "Rating of the proposal",:owner_rating
    column "Proposal message",:owner_msg
    column "Public",:is_visible
    column :created_at
    column :updated_at
    default_actions


  end
end
