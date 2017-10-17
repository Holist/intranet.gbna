json.array! @users do |user|
  json.id user.id
  json.username user.username
  json.firstname user.first_name
  json.lastname user.last_name
end
