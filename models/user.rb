class User
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :username, String
  property :password, String
  property :token, String

  has 1, :user_profile
  has n, :journals
  has n, :accounts
  has n,  :account_records, :through => :journals

end
