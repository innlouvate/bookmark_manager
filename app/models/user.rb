require 'data_mapper'
require 'dm-postgres-adapter'
require 'bcrypt'
require 'dm-validations'

class User
  include DataMapper::Resource
  include BCrypt

  attr_reader :id, :username, :email, :password

  property :id, Serial
  property :username, String, :required => true
  property :email, String, :required => true, :format => :email_address
  property :password, BCryptHash, :required => true, :length => 60..60
  attr_accessor :password_confirmation

  has n, :links, :through => Resource

  validates_confirmation_of :password
  validates_presence_of :password_confirmation, :email, :username

end
