module PathRewriterHelper

  ["exchange", "exchange_proposal", "exchange_proposal_comment", "page"].each do |resource|
    [resource, resource.pluralize].each do |r|
      src = <<-end_src
        def #{r}_path(*args)
          if !@current_person_in_need.nil?
            return organization_people_in_need_#{r}_path(@current_organization, @current_person_in_need, *args)
          elsif !@current_organization.nil?
            return organization_#{r}_path(@current_organization, *args)
          else
            super
          end
        end

        def #{r}_url(*args)
          if !@current_person_in_need.nil?
            return organization_people_in_need_#{r}_url(@current_organization, @current_person_in_need, *args)
          elsif !@current_organization.nil?
            return organization_#{r}_url(@current_organization, *args)
          else
            super
          end
        end
      end_src
      module_eval src, __FILE__, __LINE__
    end

    src = <<-end_src
      def #{resource}_author_path(*args)
        if !@current_person_in_need.nil?
            return organization_people_in_need_#{resource}_author_path(@current_organization, @current_person_in_need, *args)
          elsif !@current_organization.nil?
          return organization_#{resource}_author_path(@current_organization, *args)
        else
          super
        end
      end

      def edit_#{resource}_path(*args)
        if !@current_person_in_need.nil?
            return edit_organization_people_in_need_#{resource}_path(@current_organization, @current_person_in_need, *args)
          elsif !@current_organization.nil?
          return edit_organization_#{resource}_path(@current_organization, *args)
        else
          super
        end
      end

      def new_#{resource}_path(*args)
        if !@current_person_in_need.nil?
            return new_organization_people_in_need_#{resource}_path(@current_organization, @current_person_in_need, *args)
          elsif !@current_organization.nil?
          return new_organization_#{resource}_path(@current_organization, *args)
        else
          super
        end
      end

      def #{resource}_author_url(*args)
        if !@current_person_in_need.nil?
            return organization_people_in_need_#{resource}_author_url(@current_organization, @current_person_in_need, *args)
          elsif !@current_organization.nil?
          return organization_#{resource}_author_url(@current_organization, *args)
        else
          super
        end
      end

      def edit_#{resource}_url(*args)
        if !@current_person_in_need.nil?
            return edit_organization_people_in_need_#{resource}_url(@current_organization, @current_person_in_need, *args)
          elsif !@current_organization.nil?
          return edit_organization_#{resource}_url(@current_organization, *args)
        else
          super
        end
      end

      def new_#{resource}_url(*args)
        if !@current_person_in_need.nil?
            return new_organization_people_in_need_#{resource}_url(@current_organization, @current_person_in_need, *args)
          elsif !@current_organization.nil?
          return new_organization_#{resource}_url(@current_organization, *args)
        else
          super
        end
      end

    end_src
    module_eval src, __FILE__, __LINE__
  end

  def rewrite_current_with_organization(organization)
    path_to_rewrite = ["exchanges", "proposals","comments","pages"]
    recognized_path = Rails.application.routes.recognize_path(request.env['PATH_INFO'])
    if organization.nil?
      if recognized_path[:controller] == "organizations" || recognized_path[:controller] == "assistances" || current_page?(root_url) || current_page?("/")
        root_path
      else
        url_for(:organization_id => nil, :people_in_need_id => nil, :only_path => true)
      end
    elsif path_to_rewrite.include?(recognized_path[:controller]) && !current_page?(root_url) && !current_page?("/")
        url_for(:organization_id => organization.id, :people_in_need_id => nil, :only_path => true)
    else
      organization_path(organization)
    end
  end

  def rewrite_current_with_person_in_need(person_in_need)
    path_to_rewrite = ["exchanges", "proposals","comments","pages"]
    recognized_path = Rails.application.routes.recognize_path(request.env['PATH_INFO'])
    if person_in_need.nil?
      if recognized_path[:controller] == "assistances"  || current_page?(root_url) || current_page?("/")
        organization_path(@current_organization)
      else
        url_for(:people_in_need_id => nil, :only_path => true)
      end

    elsif path_to_rewrite.include?(recognized_path[:controller]) && !current_page?(root_url) && !current_page?("/")
      url_for(:people_in_need_id => person_in_need.id, :only_path => true)
    else
      organization_people_in_need_path(@current_organization, person_in_need)
    end
  end

  def rewrite_current_with_locale(locale)
    if !current_page?(root_url) && !current_page?("/")
      url_for(:locale => locale, :only_path => true)
    else
      root_path(:locale => locale)
    end

  end


end
