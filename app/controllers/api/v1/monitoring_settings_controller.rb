class Api::V1::MonitoringSettingsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
  end

  def show
    begin
      monitoring_setting = MonitoringSetting.find(params[:id])
      attempts = monitoring_setting.attempts
      render json: {:success => true, :monitoring_setting => monitoring_setting, :attempts => attempts}
    rescue StandardError => error
      render json: {:success => false, :msg => error.message}
    end
  end

  def create
    user = User.find(params[:id])
    monitoring_setting = user.monitoring_settings.new(monitoring_setting_params)
    if user.save
      render json: monitoring_setting, status: :created
    else
      render json: monitoring_setting.errors, status: :unprocessable_entity
    end
  end

  def update
    monitoring_setting = MonitoringSetting.find(params[:id])
    if monitoring_setting.update_attributes(update_monitoring_setting_params)
      render json: monitoring_setting
    else
      render json: monitoring_setting.errors, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      monitoring_setting = MonitoringSetting.find(params[:id])
      monitoring_setting.destroy
      render json: {:success => true, :monitoring_setting => monitoring_setting}
    rescue StandardError => error
      render json: {:success => false, :msg => error.message}
    end
  end

  def import_csv
    MonitoringSetting.import(params[:file])
  end

  private

    def monitoring_setting_params
      params.require(:monitoring_setting).permit(:url, :verification_timing, :user_id)
    end

    def update_monitoring_setting_params
      params.permit(:url, :verification_timing)
    end

end
