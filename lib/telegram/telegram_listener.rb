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
    puts "parsing message #{update}".yellow
	message = update['message']
    chat = message['chat'] if message
    username = chat['username'] if chat
	entities = {
	  'mention': [],
	  'hashtag': [],
      'bot_command': [],
      'url': [],
      'email': [],
      'bold': [],
      'italic': [],
      'code': [],
      'pre': [],
      'text_link': [],
      'text_mention': []
	}
	if message['entities'] 
	  message['entities'].each do |entity|
		puts "processing entity #{entity}".cyan
	    entities[entity['type']] << message['text'][entity['offset'], entity['length']]
      end
	end
    {
      username: username,
      chat_id: chat['id'],
      text: message['text'],
	  entities: entities
    }
  end
 end
