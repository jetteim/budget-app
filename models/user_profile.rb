class UserProfile
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :avatar, String
  property :lang, String
  property :username, String
  property :email, String
  property :facebook, String
  property :twitter, String
  property :google, String
  
  belongs_to :user
  
end
