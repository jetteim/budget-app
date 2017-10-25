class TelegramListener
  require 'telegramAPI'

  def initialize(token)
    @api = TelegramAPI.new(token)
  end

  def updates_bundle
    updates = @api.getUpdates('timeout' => 180)
    bundle = {}
    updates.each do |update|
      next unless (message = parse_update(update))
      next unless (username = message[:username])
      bundle[username] = [] unless bundle[username]
      bundle[username] << message
    end
    return bundle
  rescue RestClient::Exception => e
    puts e.response.to_s.red
  end

  def parse_update(update)
    message = update['message']
    chat = message['chat'] if message
    username = chat['username'] if chat
	entities = []
	if message['entities']
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
    {
      username: username,
      chat_id: chat['id'],
      text: message['text']
    }
  end
 end
