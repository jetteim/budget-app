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
        rescue StandardError => detail
          puts detail.inspect.red
          puts detail.backtrace.join("\n").red
          # raise
        end
      end
    end
  end

  def reply_bundle(bundle)
    bundle.each { |reply| send_reply(reply) }
  end

  def send_reply(reply)
    @responders.add(Thread.new do
      begin
        puts "sending reply: #{reply.inspect}".magenta
        res = @api.sendMessage(reply[:chat_id], reply[:reply])
      rescue StandardError => detail
        puts detail.inspect.red
        puts detail.backtrace.join("\n").red
        raise
      end
    end)
    check_senders_queue
  end

  def check_senders_queue
    loop do
      pending = @responders.list.select(&:alive?)
      break unless pending.count > MAX_RESPONDERS
      puts 'responders queue overloaded, waiting for garbage collector to proceed'.red
      sleep(1)
    end
  end
end
