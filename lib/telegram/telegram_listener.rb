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
    {
      username: username,
      chat_id: chat['id'],
      text: message['text']
    }
  end
 end