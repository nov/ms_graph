require 'active_support'
require 'active_support/core_ext'
require 'rack/oauth2'

module MsGraph
  mattr_accessor :root_url, :api_version, :gem_version, :logger, :debugging, :_http_config_, :object_classes

  self.root_url = 'https://graph.microsoft.com'
  self.api_version = 'v1.0'
  self.gem_version = File.read(File.join(__dir__, '../VERSION')).strip
  self.logger = Logger.new(STDOUT)
  self.logger.progname = 'MsGraph'

  class << self
    def debugging?
      !!self.debugging
    end
    def debug!
      Rack::OAuth2.debug!
      self.debugging = true
    end

    def http_client(access_token = nil)
      _http_client_ = HTTPClient.new(
        agent_name: "MsGraph (#{gem_version})"
      )
      _http_client_.request_filter.delete_if do |filter|
        filter.is_a? HTTPClient::WWWAuth
      end
      _http_client_.request_filter << RequestFilter::Authenticator.new(access_token) if access_token.present?
      _http_client_.request_filter << RequestFilter::Debugger.new if self.debugging?
      _http_config_.try(:call, _http_client_)
      _http_client_
    end
    def http_config(&block)
      Rack::OAuth2.http_config &block unless Rack::OAuth2.http_config
      self._http_config_ ||= block
    end
  end
end

require 'ms_graph/node'
[
  '',
  'request_filter'
].each do |dir|
  Dir[File.join(__dir__, 'ms_graph', dir, '*.rb')].each do |file|
    require file
  end
end