class CreateAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :attempts do |t|
      t.string :status
      t.references :monitoring_setting, null: false, foreign_key: true

      t.timestamps
    end
  end
end
