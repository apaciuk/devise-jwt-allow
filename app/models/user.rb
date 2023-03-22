# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  username               :string           default(""), not null
#  display_name           :string           default(""), not null
#  slug                   :string           default(""), not null
#  address                :string           default(""), not null
#  city                   :string           default(""), not null
#  postcode               :string           default(""), not null
#  country                :string           default(""), not null
#  phone                  :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_display_name          (display_name)
#  index_users_on_email                 (email)
#  index_users_on_reset_password_token  (reset_password_token)
#  index_users_on_slug                  (slug)
#  index_users_on_username              (username)
#
class User < ApplicationRecord
  include Users::Allowlist
  include Users::Associations
  include Users::Logic
  include Users::Validations

  devise :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable,
    :jwt_authenticatable,
    jwt_revocation_strategy: self

  extend FriendlyId
  friendly_id :username, use: [:slugged]

  # DEVISE-specific things
  # Devise override for logging in with username or email
  attr_writer :login

  def login
    @login || username || email
  end

  # Use :login for searching username and email
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where([
      "lower(username) = :value OR lower(email) = :value",
      { value: login.strip.downcase },
    ]).first
  end

  # Make sure to send the devise emails via async
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
