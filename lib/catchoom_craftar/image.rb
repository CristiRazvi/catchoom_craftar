class CatchoomCraftar::Image < CatchoomCraftar::Base
  ATTRS = [:uuid, :file, :item, :name, :resource_uri, :status, :thumb_120, :thumb_60, :tracking_data_status, :api_key, :quality]
  attr_reader *ATTRS


  def initialize( uuid: nil,
                  file: nil,
                  item: nil,
                  name: nil,
                  resource_uri: nil,
                  status: nil,
                  thumb_120: nil,
                  thumb_60: nil,
                  tracking_data_status: nil,
                  api_key: nil,
                  quality: nil )
    @uuid                 = uuid
    @file                 = file
    @item                 = item
    @name                 = name
    @resource_uri         = resource_uri
    @status               = status
    @thumb_120            = thumb_120
    @thumb_60             = thumb_60
    @tracking_data_status = tracking_data_status
    @api_key              = api_key
    @quality              = quality
  end

  # content type is generally application json, in some cases multipart/form-data
  def content_type
    "multipart/form-data;"
  end

  # content type is generally application json, in some cases multipart/form-data
  def multipart_flag
    true
  end

end