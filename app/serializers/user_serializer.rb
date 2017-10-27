class BalanceSerializer < ActiveModel::Serializer
  attributes :username, :email, :token
end
