class Status < ActiveRecord::Migration[5.2]

  def change
    add_column :users, :status, :string, :default => "On Duty"

  end
end
