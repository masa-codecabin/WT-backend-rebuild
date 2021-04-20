class CreateUserAndMonitoringSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :user_and_monitoring_settings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :monitoring_setting, null: false, foreign_key: true

      t.timestamps
    end
  end
end
