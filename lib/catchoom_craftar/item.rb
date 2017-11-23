class CatchoomCraftar::Item < CatchoomCraftar::Base
  ATTRS = [:name, :collection, :tags, :url, :content, :custom, :trackable]
  attr_reader *ATTRS


  def initialize( name: nil,
                  collection: nil,
                  tags: nil,
                  url: nil,
                  content: nil,
                  custom: nil,
                  trackable: nil )
    @name       = name
    @collection = collection
    @tags       = tags
    @url        = url
    @content    = content
    @custom     = custom
    @trackable  = trackable
  end

end