migration 2, :create_user_profiles do
  up do
    create_table :user_profiles do
      column :id, Integer, :serial => true
      column :avatar, DataMapper::Property::String, :length => 255
      column :lang, DataMapper::Property::String, :length => 255
      column :username, DataMapper::Property::String, :length => 255
      column :email, DataMapper::Property::String, :length => 255
      column :facebook, DataMapper::Property::String, :length => 255
      column :twitter, DataMapper::Property::String, :length => 255
      column :google, DataMapper::Property::String, :length => 255
      column :user_id, DataMapper::Property::Integer
    end
  end

  down do
    drop_table :user_profiles
  end
end
