migration 2, :create_user_profiles do
  up do
    create_table :user_profiles do
      column :id, Integer, :serial => true
      column :password, DataMapper::Property::String, :length => 255
      column :avatar, DataMapper::Property::String, :length => 255
      column :lang, DataMapper::Property::String, :length => 255
    end
  end

  down do
    drop_table :user_profiles
  end
end
