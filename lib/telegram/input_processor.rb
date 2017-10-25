class InputProcessor
  def process_telegram(user, input)
    puts "processing updates from user #{user}: #{input.inspect}".green
    chats = {}
    input.each do |message|
      chat_id = message[:chat_id]
      chats[chat_id] = [] unless chats[chat_id]
	  chats[chat_id] << "commands received: #{message[:entities][:bot_command]}" if message[:entities][:bot_command]
      chats[chat_id] << message[:text]
    end
    replies = []
    chats.each do |id, updates|
      # `say #{updates}`
      replies << {
        chat_id: id,
        reply: "got #{updates.count} updates from user #{user}: #{updates}"
      }
    end
    replies
  end
end
