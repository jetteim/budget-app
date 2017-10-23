class TelegramListener
  require 'telegramAPI'

  def initialize(token)
    @api = TelegramAPI.new(token)
  end

  def getUpdatesBunlde
    updates = @api.getUpdates('timeout' => 180)
    puts "got updates from telegram: #{updates.inspect}".cyan
    bundle = {}
    updates.each do |update|
      next unless message = parse_update(update)
      next unless username = message[:username]
      bundle[username] = [] unless bundle[username]
      bundle[username] << message
    end
    puts "updates grouped by username and bundled: #{bundle}".magenta
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
