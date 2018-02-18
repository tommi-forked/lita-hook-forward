module HookForwardHelpers
  class LitaTarget
    class << self
      def call(name)
        if name[0] == '#'
          name = name[1..-1]
          room = Lita::Room.find_by_name(name)
          source = Lita::Source.new(room: room.id)

          { lita_room_or_user: room, lita_source: source }
        else
          user = Lita::User.fuzzy_find(name)
          source = Lita::Source.new(user: user)

          { lita_room_or_user: user, lita_source: source }
         end
      end
    end
  end
end
