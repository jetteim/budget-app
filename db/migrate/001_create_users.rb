migration 1, :create_users do
  up do
    create_table :users do
      column :id, Integer, :serial => true
      column :username, DataMapper::Property::String, :length => 255
      column :email, DataMapper::Property::String, :length => 255
      column :password, DataMapper::Property::String, :length => 255
      column :avatar, DataMapper::Property::String, :length => 255
      column :lang, DataMapper::Property::String, :length => 255
      column :token, DataMapper::Property::String, :length => 255
    end
  end

  down do
    drop_table :users
  end
end
