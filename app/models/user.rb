# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :user_and_monitoring_settings
  has_many :monitoring_settings, through: :user_and_monitoring_settings, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:twitter, :facebook, :google_oauth2]
  include DeviseTokenAuth::Concerns::User
end
