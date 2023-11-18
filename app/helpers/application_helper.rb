module ApplicationHelper
  def flash_class(message_type)
    case message_type
    when 'notice' then 'bg-green-100 border border-green-400 text-green-700'
    when 'alert'  then 'bg-red-100 border border-red-400 text-red-700'
    when 'dander'  then 'bg-red-300 border border-red-400 text-red-700'
    when 'info'   then 'bg-blue-100 border border-blue-400 text-blue-700'
    else 'bg-gray-100 border border-gray-400 text-gray-700'
    end
  end
end
