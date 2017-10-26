class InputProcessor
  def initialize
    # здесь надо загружать сохранённую сессию если есть
    @pending = {}
  end

  def process_telegram(user, input)
    @outgoing = []
    puts "processing updates from user #{user}: #{input.inspect}".green
    chats = {}
    input.each do |message|
      command_reply(user, message) if @pending[user]
      chat_id = message[:chat_id]
      chats[chat_id] = [] unless chats[chat_id]
      if message[:entities] && message[:entities]['bot_command']
        do_commands(user, message[:entities]['bot_command']).each do |u|
          @outgoing << {
            chat_id: chat_id,
            reply: u
          }
        end
      end
      chats[chat_id] << message[:text]
    end
    chats.each do |id, updates|
      # `say #{updates}`
      @outgoing << {
        chat_id: id,
        reply: "got #{updates.count} updates from user #{user}: #{updates}"
      }
    end
    @outgoing.flatten
  end

  def do_commands(user, commands)
    puts "commands received: #{commands.inspect}".cyan
    @pending[user] = [] unless @pending[user]
    instant_replies = []
    commands.each do |command|
      case command
      when '/register'
        @pending[user] = :register
        instant_replies << 'please send token string from your profile'
      when '/report'
        #
      when '/add'
        #
      when '/categories'
        #
      end
    end
    instant_replies
  end

  def command_reply(user, message)
    return bind_token(user, message[:text]) if @pending[user] && @pending[user] == :register
  end

  def bind_token(user, string)
    puts "binding token #{string} for user #{user}"
  end
end
