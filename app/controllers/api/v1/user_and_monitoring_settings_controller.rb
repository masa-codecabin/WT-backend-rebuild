class Api::V1::UserAndMonitoringSettingsController < ApplicationController
  def index
  end

  def show
  end

  def create
    user_and_monitoring_setting = UserAndMonitoringSetting.new(user_and_monitoring_setting_params)
    if user_and_monitoring_setting.save
      render json: user_and_monitoring_setting, status: :created
    else
      render json: user_and_monitoring_setting.errors, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

    def user_and_monitoring_setting_params
      params.permit(:user_id, :monitoring_setting_id)
    end
end
