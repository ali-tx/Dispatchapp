class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|

      t.string :details
      t.string :status
      t.float :source_long
      t.float :source_lat
      t.float :destination_long
      t.float :destination_lat


      t.timestamps
    end
  end
end
