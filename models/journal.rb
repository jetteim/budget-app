class Journal
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :name, String

  belongs_to :user
  has n, :accounts
  has n, :account_records
end
