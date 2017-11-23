require "catchoom_craftar/version"

require "enumerable/symbolizable"

require "catchoom_craftar/base"
require "catchoom_craftar/collection"
require "catchoom_craftar/item"
require "catchoom_craftar/image"

module CatchoomCraftar

  class << self
    attr_writer :management_api_key

    def management_api_key
      @management_api_key ||= ENV["CATCHOOM_CRAFTAR_MANAGEMENT_API_KEY"]
    end
  end

end
