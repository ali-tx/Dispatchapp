class AddJobReferenceToRequest < ActiveRecord::Migration[5.2]
  def change
    add_reference :requests, :job, foreign_key: true,index:true

  end
end
