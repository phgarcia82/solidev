ActiveAdmin.register Comment, :as => "ProposalComment" do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :proposal_id, :user_id, :organization_id, :person_in_need_id, :content
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
    column :content
    column "Proposal concerned",:proposal_id
    column "author",:user_id
    column :organization_id
    column :person_in_need_id
    column :created_at
    column :updated_at
    default_actions

  end
end
