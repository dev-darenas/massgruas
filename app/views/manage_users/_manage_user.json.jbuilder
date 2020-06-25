json.extract! user, :id, :fullname, :email, :rol, :created_at, :updated_at
json.url manage_user_url(user, format: :json)
