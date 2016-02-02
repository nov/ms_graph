module MsGraph
  class User < Node
    def initialize(id, attributes = {})
      super
    end

    class << self
      def me(access_token)
        new(:me).authenticate(access_token)
      end

      def all(access_token)

      end
    end
  end
end