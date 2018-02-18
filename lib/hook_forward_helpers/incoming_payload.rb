module HookForwardHelpers
  class IncomingPayload
    attr_reader :request_params

    def initialize(request_params)
      @request_params = request_params
    end

    def targets
      return @targets if @targets

      targets = request_params['targets'] || Lita.config.handlers.hook_forward.default_room
      @targets = targets.split(',')
    end

    def message
      # Falls back to attachment's text if message params does not exist
      @message ||= request_params['message'] || attachment.text
    end

    def attachment
      return @attachment if @attachment

      @attachment = if request_params['attachment']
        HookForwardHelpers::Attachment.new(request_params['attachment']).call
      end
    end
  end
end
