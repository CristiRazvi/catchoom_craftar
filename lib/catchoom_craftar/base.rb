require 'rest-client'
require 'json'
require 'pry'

class CatchoomCraftar::Base

  API_BASE_URI = "https://my.craftar.net/api/v0"

  class << self
    # resource name
    def craftar_type
      self.name.split("::")[1].downcase
    end

    # payload for list elements
    def payload_for_list
      { api_key: CatchoomCraftar.management_api_key }
    end

    # list items
    def list
      rescue_known_exceptions do
        response = RestClient.get(self.build_path, params: payload_for_list)
        response_hash = JSON.parse(response)
        response_hash["objects"].map{ |obj| self.new(obj.symbolize_keys) }
      end
    end

    # create method like in rails
    def create(args)
      resource = self.new(args)
      resource.save
    end

    def build_path
      API_BASE_URI + "/#{self.craftar_type}/?api_key=#{CatchoomCraftar.management_api_key}"
    end
  end

  def save
    rescue_known_exceptions do
      response = RestClient.post( self.class.build_path, payload.to_json, content_type: "application/json")
      response_hash = JSON.parse(response)
      self.class.new(response_hash.symbolize_keys)
    end
  end

  private
    # attributes sent to craftar API
    def payload
      response = { }

      api_key_hash = { api_key: CatchoomCraftar.management_api_key }
      self.class::ATTRS.each do |attr|
        response[attr] = self.send(attr) unless self.send(attr).nil?
      end

      response.merge(api_key_hash)
    end

    # handle exceptions on requests
    #
    def rescue_known_exceptions
      self.class.rescue_known_exceptions{ yield }
    end
    def self.rescue_known_exceptions
      begin
        yield
      rescue RestClient::BadRequest => bad_request_error
        error_hash = JSON.parse(bad_request_error.response.body)
        raise error_hash["error"]["code"] + " : " + error_hash["error"]["message"] + "\n" + error_hash["error"]["details"].map{ |k,v| "#{k} : #{v.join('; ')}" }.join("\n")
      rescue RestClient::Forbidden => forbidden_error
        error_hash = JSON.parse(forbidden_error.response.body)
        if error_hash["error"] && error_hash["error"]["code"] == "COLLECTION_QUOTA_EXCEEDED"
          raise error_hash["error"]["message"]
        else
          forbidden_error
        end
      end
    end
    #
    # handle exceptions on requests

end
