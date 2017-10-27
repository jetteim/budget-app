class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string   'username', limit: 255, null: false
      t.string   'email', limit: 255, null: false
      t.string   'token', limit: 255, null: false
      t.timestamps
    end
  end
end
