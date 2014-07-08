class AccessTokenSerializer < ActiveModel::Serializer
  embed :ids

  attributes :access_token, :expires_in

  has_one :user
end
