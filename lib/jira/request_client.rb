require 'oauth'
require 'json'
require 'net/https'

module JIRA
  class RequestClient
    # Returns the response if the request was successful (HTTP::2xx) and
    # raises a JIRA::HTTPError if it was not successful, with the response
    # attached.

    def request(*args)
      response = make_request(*args)
      
      unless response.is_a?(Net::HTTPSuccess)
        puts "*************************************************************************************************"
        puts "HTTP ERROR: code = #{response.code}, res = #{response.message}"
        puts "HTTP ERROR: inspect = #{response.inspect}"
        puts "*************************************************************************************************"
        raise HTTPError, response
      end
      
      # raise HTTPError.new(response.code, response.message), response unless response.is_a?(Net::HTTPSuccess)
      response
    end

    def request_multipart(*args)
      response = make_multipart_request(*args)
      
      unless response.is_a?(Net::HTTPSuccess)
        puts "*************************************************************************************************"
        puts "HTTP ERROR: code = #{response.code}, res = #{response.message}"
        puts "HTTP ERROR: inspect = #{response.inspect}"
        puts "*************************************************************************************************"
        raise HTTPError, response
      end
      # raise HTTPError.new(response.code, response.message), response unless response.is_a?(Net::HTTPSuccess)
      
      response
    end

    def make_request(*args)
      raise NotImplementedError
    end

    def make_multipart_request(*args)
      raise NotImplementedError
    end
  end
end
