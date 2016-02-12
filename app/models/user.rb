require_relative '../data_mapper_setup.rb'
require 'bcrypt'

class User
  include DataMapper::Resource

  attr_accessor :password_confirmation
  attr_reader :password, :email

  has n, :link, through: Resource

  property :id,   Serial
  property :email, String,  :required => true, :unique => true
  property :password_digest, Text
  # property :count, Integrer

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  validates_confirmation_of :password
  validates_presence_of :email
  validates_format_of :email, :as => :email_address
  validates_uniqueness_of :email
end
