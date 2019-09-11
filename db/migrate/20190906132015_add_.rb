class Add < ActiveRecord::Migration[5.2]
  def change
    # add_reference :jobs, :users, index:true
    # add_foreign_key :jobs, :users, column: :user_id
    add_reference :jobs, :user, index: true
    add_foreign_key :jobs, :users

  end

  end

