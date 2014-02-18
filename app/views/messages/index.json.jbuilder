json.array!(@messages) do |message|
  json.extract! message, :id, :title, :text, :from_user_id, :to_user_id, :conversation, :talent_id
  json.url message_url(message, format: :json)
end
