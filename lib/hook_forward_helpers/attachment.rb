module HookForwardHelpers
  class Attachment
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      return nil if params.nil?

      options = params.inject({}) { |opts, (k,v)| opts[k.to_sym] = v; opts }
      text = options.delete(:text)

      ::Lita::Adapters::Slack::Attachment.new(text, options)
    end
  end
end
