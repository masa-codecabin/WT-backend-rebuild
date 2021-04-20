class UserAndMonitoringSetting < ApplicationRecord
  belongs_to :user
  belongs_to :monitoring_setting
end
