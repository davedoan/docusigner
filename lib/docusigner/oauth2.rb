module Docusigner
  class Oauth2 < Docusigner::Base
    singleton

    class << self
      def token(username, password, integrator_key)
        @headers = {
          "Accept" => "application/json",
          "Content-Type" => "application/x-www-form-urlencoded"
        }
        body = "grant_type=password&client_id=#{integrator_key}&username=#{username}&password=#{password}&scope=api"
        resp = post(:token, {}, body) 
        format.decode(resp.body)["access_token"]
      end

      def revoke(token)
        @headers = {
          "Authorization" => "Bearer #{token}"
        }
        post(:revoke, {}, "")
      end
    end
  end
end
