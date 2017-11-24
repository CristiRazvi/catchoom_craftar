require 'rest-client'
require 'json'

class CatchoomCraftar::Base

  API_BASE_URI = "https://my.craftar.net/api/v0"
  KNOWN_REST_CLIENT_FORBIDDEN_ERRORS = ["COLLECTION_QUOTA_EXCEEDED", "AR_ITEM_IMAGE_COUNT"]

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
    def list(query_params = nil)
      rescue_known_exceptions do
        response = RestClient.get(self.build_path(query_params), params: payload_for_list)
        response_hash = JSON.parse(response)
        response_hash["objects"].map{ |obj| self.new(obj.symbolize_keys) }
      end
    end

    # create method like in rails
    def create(args)
      resource = self.new(args)
      resource.save
    end

    def build_path(query_params = nil)
      query_params ||= {}
      query_params.merge!({ api_key: CatchoomCraftar.management_api_key })
      API_BASE_URI + "/#{self.craftar_type}/?#{URI.encode_www_form(query_params)}"
    end
  end

  def save
    rescue_known_exceptions do
      response = RestClient.post(self.class.build_path, payload, content_type: content_type)
      response_hash = JSON.parse(response)
      self.class.new(response_hash.symbolize_keys)
    end
  end


  private
    # attributes sent to craftar API
    def payload
      response = { }
      self.class::ATTRS.each do |attr|
        response[attr] = self.send(attr) unless self.send(attr).nil?
      end

      if multipart_flag
        default_options = { api_key: CatchoomCraftar.management_api_key, multipart: multipart_flag }
        response.merge(default_options)
      else
        default_options = { api_key: CatchoomCraftar.management_api_key }
        response.merge(default_options).to_json
      end
    end

    # content type is generally application json, in some cases multipart/form-data
    def content_type
      "application/json"
    end

    # content type is generally application json, in some cases multipart/form-data
    def multipart_flag
      false
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
        if error_hash["error"]
          error_details = error_hash["error"]["details"] ? error_hash["error"]["details"].map{ |k,v| "#{k} : #{v.join('; ')}" }.join("\n") : ""
          raise error_hash["error"]["code"] + " : " + error_hash["error"]["message"] + "\n" + error_details
        else
          bad_request_error
        end
      rescue RestClient::Forbidden => forbidden_error
        error_hash = JSON.parse(forbidden_error.response.body)
        if error_hash["error"] && KNOWN_REST_CLIENT_FORBIDDEN_ERRORS.include?(error_hash["error"]["code"])
          raise error_hash["error"]["message"]
        else
          forbidden_error
        end
      end
    end
    #
    # handle exceptions on requests

end
