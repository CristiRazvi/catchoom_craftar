class CatchoomCraftar::Item < CatchoomCraftar::Base
  ATTRS = [:name, :collection, :tags, :url, :content, :custom, :trackable, :resource_uri, :uuid, :api_key]
  attr_reader *ATTRS


  def initialize( name: nil,
                  collection: nil,
                  tags: nil,
                  url: nil,
                  content: nil,
                  custom: nil,
                  trackable: nil,
                  resource_uri: nil,
                  uuid: nil,
                  api_key: nil )
    @name         = name
    @collection   = collection
    @tags         = tags
    @url          = url
    @content      = content
    @custom       = custom
    @trackable    = trackable
    @resource_uri = resource_uri
    @uuid         = uuid
    @api_key      = api_key
  end

end