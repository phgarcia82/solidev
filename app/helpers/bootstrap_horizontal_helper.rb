module BootstrapHorizontalHelper

  [:form_for, :form_remote_for, :remote_form_for].each do |meth|
    src = <<-end_src
      def bootstrap_horizontal_#{meth}(object_name, *args, &proc)
        options = args.last.is_a?(Hash) ? args.pop : {}
        if !options.has_key?(:html)
          options[:html] = {}
        end
        options.update(:builder => BootstrapHorizontalHelper::Builder, :html => options[:html].merge({ :class => "form-horizontal", :multipart => true}))
        #{meth}(object_name, *(args << options), &proc)
      end
    end_src
    module_eval src, __FILE__, __LINE__
  end

  class Builder < ActionView::Helpers::FormBuilder

    def wrap(input, options)
      col_sm = options.has_key?(:col_sm) ? options[:col_sm] : 3
      if col_sm.nil?
        return input
      end
      html = <<-html
        <div class="col-sm-#{col_sm}">
          #{input}
        </div>
      html
      html.html_safe
    end

    def wrap_check_box(input, options)
      col_sm = options.has_key?(:col_sm) ? options[:col_sm] : 3
      col_sm_offset = options.has_key?(:col_sm_offset) ? options[:col_sm_offset] : 0
      html = <<-html
        <div class="col-sm-#{col_sm} col-sm-offset-#{col_sm_offset}">
          <div class="checkbox" style="padding-top: 0;">
            <label>
              #{input} #{options[:label]}
            </label>
          </div>
        </div>
      html
      html.html_safe
    end

    def text_field(method, options={})
      wrap(super(method, options.merge({:class => "form-control #{options[:class]}"}).except(:col_sm)),options)
    end

    def password_field(method, options={})
      wrap(super(method, options.merge({:class => "form-control #{options[:class]}"}).except(:col_sm)),options)
    end

    def email_field(method, options={})
      wrap(super(method, options.merge({:class => "form-control #{options[:class]}"}).except(:col_sm)),options)
    end

    def file_field(method, options={})
      wrap(super(method, options.merge({:class => "btn #{options[:class]}"}).except(:col_sm)),options)
    end

    def text_area(method, options={})
      wrap(super(method, options.merge({:class => "form-control #{options[:class]}"}).except(:col_sm)),options)
    end

    def check_box(method, options={})
      wrap_check_box(super(method, options.except(:col_sm, :col_sm_offset, :label)),options)
    end

    def date_select(method, options={}, html_options = {})
      wrap(super(method, options, html_options.merge({:class => "form-control #{html_options[:class]}"}).except(:col_sm)),html_options)
    end

    def country_select(method, options={})
      countries = Country.all.collect do |code|
        c = Country[code[1]]
        [I18n.t(code[1], :scope => "countries"), c.number.to_i, {'data-code' => c.alpha2.downcase}]
      end
      countries.unshift([I18n.t(:BE, :scope => "countries"), 56, {"data-code"=>"be"}], [I18n.t(:FR, :scope => "countries"), 250, {"data-code"=>"fr"}])
      wrap(select(method, countries, {}, options.merge({:class => "form-control #{options[:class]}"}).except(:col_sm)),options)
    end

    def submit(method = nil, options={}, &block)
      super(method, options.merge({:class => "btn btn-primary #{options[:class]}"}), &block)
    end

    def label(method, text = nil, options = {}, &block)
      col_sm = text.is_a?(Hash) && text.has_key?(:col_sm) ? text[:col_sm] : 3
      col_sm = options.has_key?(:col_sm) ? options[:col_sm] : col_sm
      col_sm_string = col_sm.nil? ? "" : "col-sm-#{col_sm}"
      super(method, text, options.merge({:class => "control-label #{col_sm_string} #{options[:class]}"}).except(:col_sm), &block)
    end

  end
end
