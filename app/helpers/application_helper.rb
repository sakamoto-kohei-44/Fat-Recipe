module ApplicationHelper
  def flash_class(message_type)
    case message_type
    when 'notice' then 'bg-green-100 border border-green-400 text-green-700'
    when 'alert'  then 'bg-red-100 border border-red-400 text-red-700'
    when 'danger'  then 'bg-red-300 border border-red-400 text-red-700'
    when 'info'   then 'bg-blue-100 border border-blue-400 text-blue-700'
    else 'bg-gray-100 border border-gray-400 text-gray-700'
    end
  end

  def user_stats(value, title_key, unit_key, icon)
    render partial: 'shared/user_stat', locals: { value: value, title_key: title_key, unit_key: unit_key, icon: icon }
  end

  def form_group(form, attribute, label_key, placeholder_key)
    render partial: 'shared/form_group', locals: { form: form, attribute: attribute, label_key: label_key, placeholder_key: placeholder_key }
  end
end
