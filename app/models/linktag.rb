require 'data_mapper'
require 'dm-postgres-adapter'

class LinkTag
  include DataMapper::Resource

  property :link_id, Integer
  property :tag_id, Integer

  belongs_to :link
  belongs_to :tag

end

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
