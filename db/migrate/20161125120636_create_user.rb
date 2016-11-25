class CreateUser < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :uid, index: true
      t.string :name
      t.string :token
      t.string :secret
    end
  end
end
