class MonitoringSetting < ApplicationRecord
  has_many :attempts, dependent: :destroy
  has_many :user_and_monitoring_settings
  has_many :users, through: :user_and_monitoring_settings, dependent: :destroy
end
