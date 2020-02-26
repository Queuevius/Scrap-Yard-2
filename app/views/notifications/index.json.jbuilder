json.array! @notifications do |notification|
  #20 min
  json.id notification.id
  json.actor notification.actor
  json.action notification.action
  json.notifiable do
    json.type "#{notification.notifiable.class.to_s.underscore}"
  end
  json.url room_path(notification.notifiable.room, anchor:dom_id(notification.notifiable))
end