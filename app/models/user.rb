require 'data_mapper'
require 'dm-postgres-adapter'
require 'bcrypt'
require 'dm-validations'

class User
  include DataMapper::Resource
  include BCrypt

  attr_reader :id, :username, :email, :password

  property :id, Serial
  property :username, String
  property :email, String
  property :password, BCryptHash
  attr_accessor :password_confirmation

  has n, :links, :through => Resource

  validates_confirmation_of :password

end
