require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Coveragebook < OmniAuth::Strategies::OAuth2
      option :name, :coveragebook

      option :client_options, {
        :site => ENV['COVERAGEBOOK_OAUTH_ROOT_URL'] ? ENV['COVERAGEBOOK_OAUTH_ROOT_URL'] : 'https://accounts.coveragebook.com',
        :authorize_url => '/oauth/authorize'
      }

      uid { raw_info["id"] }

      info do
        {
          :email => raw_info["email"]
          # and anything else you want to return to your API consumers
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/me.json').parsed
      end

      # https://github.com/intridea/omniauth-oauth2/issues/81
      def callback_url
        full_host + script_name + callback_path
      end

    end
  end
end
