class BalanceSerializer < ActiveModel::Serializer
  attributes :date, :balance, :account_id, :name
  
  def name
	object.account.name
  end
  
end
