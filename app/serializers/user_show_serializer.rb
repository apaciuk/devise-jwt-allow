class UserShowSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :camel_lower

  attributes :id,
    :display_name, :slug, :username, :email, :address, :city, :postcode, :country, :phone
end
