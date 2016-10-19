class AddDiagnosisToRx < ActiveRecord::Migration[5.0]
  def change
    add_column :rxes, :diagnosis_id, :integer
  end
end
