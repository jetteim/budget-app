class User
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :username, String
  property :password, String
  property :token, String
  
end
