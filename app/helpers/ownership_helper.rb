module OwnershipHelper

  def is_owner(resource)
    if !resource.person_in_need.nil? || !@current_person_in_need.nil?
      return resource.person_in_need == @current_person_in_need
    elsif !resource.organization.nil? || !@current_organization.nil?
      return resource.organization == @current_organization
    elsif !resource.user.nil? || !current_user.nil?
      return resource.user == current_user
    end
    return false
  end

  def set_ownership(resource)
    resource.user = current_user
    resource.organization = @current_organization
    resource.person_in_need = @current_person_in_need
  end

  def owner_image(resource)
    if !resource.person_in_need.nil?
      return resource.person_in_need.avatar
    elsif !resource.organization.nil?
      return resource.organization.logo
    elsif !resource.user.nil?
      return resource.user.avatar
    else
      return false
    end
  end

  def owner_name(resource)
    if !resource.person_in_need.nil?
      return resource.person_in_need.full_name
    elsif !resource.organization.nil?
      return resource.organization.name
    elsif !resource.user.nil?
      return resource.user.displayed_name
    else
      return false
    end
  end

  def owner_link(resource)
    if resource.instance_of?(Exchange)
      exchange_author_path(resource)
    elsif resource.instance_of?(Proposal)
      exchange_proposal_author_path(resource.exchange, resource)
    elsif resource.instance_of?(Comment)
      exchange_proposal_comment_author_path(resource.proposal.exchange, resource.proposal, resource)
    end
  end

  def owner(resource)
    if !resource.person_in_need.nil?
      return resource.person_in_need
    elsif !resource.organization.nil?
      return resource.organization
    elsif !resource.user.nil?
      return resource.user
    else
      return false
    end
  end
end
