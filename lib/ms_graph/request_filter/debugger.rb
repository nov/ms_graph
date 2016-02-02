module MsGraph
  module RequestFilter
    class Debugger
      def filter_request(request)
        started = "======= [MsGraph] API REQUEST STARTED ======="
        log started, request.dump
      end

      def filter_response(request, response)
        finished = "======= [MsGraph] API REQUEST FINISHED ======="
        log '-' * 50, response.dump, finished
      end

      private

      def log(*outputs)
        outputs.each do |output|
          MsGraph.logger.info output
        end
      end
    end
  end
end