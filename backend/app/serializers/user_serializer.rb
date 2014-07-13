class UserSerializer < ActiveModel::Serializer
  embed :ids

  attributes :id, :username
end
