class BalanceSerializer < ActiveModel::Serializer
  attributes :date, :balance, :account_id, :name
  
  def name
	Account.find(account_id).name
  end
  
end
