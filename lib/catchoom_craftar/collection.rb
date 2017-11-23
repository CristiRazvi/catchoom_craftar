class CatchoomCraftar::Collection < CatchoomCraftar::Base
  ATTRS = [:name, :offline, :resource_uri, :uuid, :api_key]
  attr_reader *ATTRS


  def initialize( name: nil,
                  offline: nil,
                  resource_uri: nil,
                  uuid: nil,
                  api_key: nil )
    @name         = name
    @offline      = offline
    @resource_uri = resource_uri
    @uuid         = uuid
    @api_key      = api_key
  end

end