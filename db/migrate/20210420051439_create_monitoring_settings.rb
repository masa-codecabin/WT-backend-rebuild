class CreateMonitoringSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :monitoring_settings do |t|
      t.string :url
      t.string :verification_timing

      t.timestamps
    end
  end
end
