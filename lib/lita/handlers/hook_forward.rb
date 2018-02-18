module Lita
  module Handlers
    class HookForward < Handler

      #noinspection RubyArgCount
      http.get '/lita/hook-forward', :receive
      http.post '/lita/hook-forward', :receive

      def self.default_config(handler_config)
        handler_config.default_room = nil
      end

      def receive(request, response)
        incoming_payload = HookForwardHelpers::IncomingPayload.new(request.params)

        incoming_payload.targets.each do |target|
          if robot.config.robot.adapter == :slack && incoming_payload.attachment
            send_slack_attachment(target, incoming_payload)
          else
            send_message(target, incoming_payload)
          end
        end
      end

      def send_message(target, incoming_payload)
        target = HookForwardHelpers::LitaTarget.call(target)[:lita_source]
        robot.send_message(target, incoming_payload.message)
      end

      def send_slack_attachment(target, incoming_payload)
        target = HookForwardHelpers::LitaTarget.call(target)[:lita_room_or_user]
        robot.chat_service.send_attachment(target, incoming_payload.attachment)
      end
    end

    Lita.register_handler(HookForward)
  end
end
