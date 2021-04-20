class Api::V1::AttemptsController < ApplicationController
  def index
  end

  def show
  end

  def create
    attempt = Attempt.new(attempt_params)
    if attempt.save
      render json: attempt, status: :created
    else
      render json: attempt.errors, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  def manual_attempt_update #run tasks after push "Manual Check" button
    require 'rake'
      Rails.application.load_tasks
      Rake::Task['monitoring_task:verify_every_10minutes'].execute
      Rake::Task['monitoring_task:verify_every_10minutes'].clear
      Rake::Task['monitoring_task:verify_every_hour'].execute
      Rake::Task['monitoring_task:verify_every_hour'].clear
      Rake::Task['monitoring_task:verify_every_3hours'].execute
      Rake::Task['monitoring_task:verify_every_3hours'].clear
  end

  private

    def attempt_params
      params.permit(:status, :monitoring_setting_id)
    end
end
