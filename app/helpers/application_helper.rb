module ApplicationHelper
  def safe_l(date_or_time, format: :default, empty_stub: nil)
    return empty_stub if date_or_time.blank?

    I18n.l(date_or_time, format: format)
  end
end
