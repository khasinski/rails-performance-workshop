module ApplicationHelper
  def page_title(current_path = nil)
    @page_subtitle ||= current_path&.split("/")&.first&.titleize
    [I18n.t("application.title"), @page_subtitle].flatten.compact.join(" - ")
  end
end
