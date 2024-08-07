class ChangeStatusInVisits < ActiveRecord::Migration[7.1]
  def change
    change_column :visits, :status, :string, null: false
  end
end
