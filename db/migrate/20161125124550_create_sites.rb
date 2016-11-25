class CreateSites < ActiveRecord::Migration[5.0]
  def change
    create_table :sites do |t|
      t.string :board_url
      t.string :board_id
      t.string :name
    end
  end
end
