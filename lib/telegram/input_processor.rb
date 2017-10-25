class InputProcessor
  def process_telegram(user, input)
    puts "processing updates from user #{user}: #{input.inspect}".green
    chats = {}
    input.each do |message|
      chat_id = message[:chat_id]
      chats[chat_id] = [] unless chats[chat_id]
      chats[chat_id] << message[:text]
	  message['entities'].each do |entity|
		case entity['type']
		when 'mention'
		when 'hashtag'
		when 'bot_command'
		when 'url'
		when 'email'
		when 'bold'
		when 'italic'
		when 'code'
		when 'pre'
		when 'text_link'
		when 'text_mention'
		end
	  end
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
