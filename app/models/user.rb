require 'data_mapper'
require 'dm-postgres-adapter'
require 'bcrypt'

class User
  include DataMapper::Resource
  include BCrypt

  attr_reader :id, :username, :email

  property :id, Serial
  property :username, String
  property :email, String
  property :password, BCryptHash

  has n, :links, :through => Resource

end
