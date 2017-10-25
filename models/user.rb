class User
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :password, String
  property :token, String
  has 1, :user_profile
  
end
