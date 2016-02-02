module MsGraph
  class Node
    attr_accessor :id, :access_token, :raw_attributes

    def initialize(id, attributes = {})
      self.id = id
      self.raw_attributes = attributes
    end

    def authenticate(access_token)
      self.access_token = access_token
      self
    end

    def fetch(params = {}, options = {})
      attributes = get params, options
      self.class.new(attributes[:id], attributes).authenticate access_token
    end

    protected

    def http_client
      MsGraph.http_client(access_token)
    end

    def get(params = {}, options = {})
      handle_response do
        http_client.get build_endpoint(options), build_params(params)
      end
    end

    def post(params = {}, options = {})
      handle_response do
        http_client.post build_endpoint(options), build_params(params)
      end
    end

    def delete(params = {}, options = {})
      handle_response do
        http_client.delete build_endpoint(options), build_params(params)
      end
    end

    private

    def edge_for(edge, params = {}, options = {})
      collection = get params, options.merge(edge: edge)
      Collection.new collection
    end

    def build_endpoint(options = {})
      path = if id == :me
        'me'
      else
        "#{self.class.to_s.tableize}/#{id}"
      end
      File.join [
        File.join(
          MsGraph.root_url,
          options[:api_version] || MsGraph.api_version,
          path
        ),
        options[:edge],
        options[:edge_scope]
      ].compact.collect(&:to_s)
    end

    def build_params(params = {})
      # TODO: OData params support?
      if params.present?
        params
      else
        nil
      end
    end

    def handle_response
      response = yield
      _response_ = MultiJson.load response.body
      _response_ = _response_.with_indifferent_access if _response_.respond_to? :with_indifferent_access
      case response.status
      when 200...300
        _response_
      else
        raise Exception.detect(response.status, _response_, response.headers)
      end
    rescue MultiJson::DecodeError
      raise Exception.new(response.status, "Unparsable Response: #{response.body}")
    end
  end
end