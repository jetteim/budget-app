class InputProcessor
  def process_telegram(user, input)
    puts "processing updates from user #{user}: #{input.inspect}".green
    chats = {}
    input.each do |message|
      chat_id = message[:chat_id]
      chats[chat_id] = [] unless chats[chat_id]
      chats[chat_id] << message[:text]
	  puts "message: #{message.inspect}".magenta
	  message['entities'].each do |entity|
		case entity['type']
		when 'mention'
		  puts "entity: #{entity.inspect}".magenta
		when 'hashtag'
		  puts "entity: #{entity.inspect}".magenta
		when 'bot_command'
		  puts "entity: #{entity.inspect}".magenta
		when 'url'
		  puts "entity: #{entity.inspect}".magenta
		when 'email'
		  puts "entity: #{entity.inspect}".magenta
		when 'bold'
		  puts "entity: #{entity.inspect}".magenta
		when 'italic'
		  puts "entity: #{entity.inspect}".magenta
		when 'code'
		  puts "entity: #{entity.inspect}".magenta
		when 'pre'
		  puts "entity: #{entity.inspect}".magenta
		when 'text_link'
		  puts "entity: #{entity.inspect}".magenta
		when 'text_mention'
		  puts "entity: #{entity.inspect}".magenta
		else
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
