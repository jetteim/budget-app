class AccountRecord
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :amount, Integer

  belongs_to :journal
  belongs_to :credit, 'Account', key: true
  belongs_to :debit, 'Account', key: true
end
