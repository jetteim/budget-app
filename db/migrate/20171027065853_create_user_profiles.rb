class CreateUserProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_profiles do |t|
      t.string 'name'
      t.string 'telegram'
      t.string 'facebook'
      t.string 'google'
      t.string 'vk'
      t.timestamps
    end
  end
end
