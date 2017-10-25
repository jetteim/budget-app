class UserProfile
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :name, String
  property :avatar, String
  property :lang, String
  property :email, String
  property :facebook, String
  property :twitter, String
  property :google, String
  
  belongs_to :user
  
end
