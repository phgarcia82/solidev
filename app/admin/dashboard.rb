ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
  columns do
    column do
      panel "Info" do
        para "Welcome to Solidare-It administration panel !"
         end
      end
    end
  end
end
