class BalanceSerializer < ActiveModel::Serializer
  attributes :date, :balance, :account_id, :name
  
  def name
	account.name
  end
  
end
