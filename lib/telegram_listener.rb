class TelegramListener
  @api = TelegramAPI.new TELEGRAM_TOKEN

  def getUpdatesBunlde
	updates = @api.getUpdates('timeout' => 180)
	p "got updates from telegram: #{updates.inspect}"
	bundle = {}
	updates.each do |update|
	   next unless message = parse_update(update)
	   next unless username = message[:username]
	   bundle[username] = [] unless bundle[username]
	   bundle[username] << message
	end
	p "updates grouped by username and bundled: #{bundle}".magenta
	bundle
  end
  
  def parse_update(update)
	message = update['message']
	chat = message['chat'] if message
	username = chat['username'] if chat
	{
	  username: username,
	  chat_id: chat['id'],
	  text: message['text']
	}
  end
  
 end 



