require 'faraday'

module Chatwork
  class Client
    HOST = 'api.chatwork.com'

    def initialize(token)
      @token = token
    end


    def post(room_id, message)
      connection.post { |request| request_params(request, "/v2/rooms/#{room_id}/messages", message: message) }
    end

    private

    def connection
      Faraday::Connection.new(faraday_client_options) do |connection|
        connection.use(Faraday::Request::UrlEncoded)
        connection.use(Faraday::Response::Logger)
        connection.use(Faraday::Adapter::NetHttp)
      end
    end

    def request_params(request, url, message: '')
      request.url(url)
      request.headers = {
        'X-ChatWorkToken' => @token
      }
      request.body = {
        :body => message
      }

      request
    end

    def faraday_client_options
      {
        url: url_prefix
      }
    end

    def url_prefix
      "https://#{HOST}"
    end
  end
end
