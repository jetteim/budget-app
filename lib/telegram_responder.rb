class TelegramResponder
  require 'telegramAPI'

  MAX_RESPONDERS = 16

  def initialize(token)
    @api = TelegramAPI.new(token)
    @responders = ThreadGroup.new

    @garbage_collector = Thread.new do
      sleep(10)
      while Thread.main.alive?
        begin
              pending = @responders.list.select(&:alive?)
              pending.each { |th| th.terminate unless th.join(10) }
              sleep(1)
            rescue => detail
              puts detail.inspect.red
              puts detail.backtrace.join("\n")
              # raise
            end
          end
    end
  end

  def replyBundle(bundle)
    puts "sending a bundle of replies: #{bundle.inspect}".green
    bundle.each { |reply| sendReply(reply) }
  end

  def sendReply(reply)
    puts "sending reply #{reply.inspect}".cyan
    @responders.add(Thread.new do
      begin
        res = @api.sendMessage(reply[:chat_id], reply[:reply])
        puts "sendMessage result: #{res.inspect}".yellow
      rescue => detail
        puts detail.backtrace.join("\n")
        raise
      end
    end)
    loop do
      pending = @responders.list.select(&:alive?)
      break unless pending.count > MAX_RESPONDERS
      puts 'responders queue overloaded, waiting for garbage collector to proceed'.red
      sleep(1)
    end
  end
end
