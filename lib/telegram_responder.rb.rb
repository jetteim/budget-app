class TelegramResponder
  @api = TelegramAPI.new TELEGRAM_TOKEN
  MAX_RESPONDERS = 16
  @responders = ThreadGroup.new

  @garbage_collector = Thread.new {
    sleep(10)
    while Thread.main.alive?
      begin
	    @responders.list.select{|p| p.alive?}.each {th.terminate unless th.join(10)}
	    sleep(1)
	  rescue => detail
	    p detail.backtrace.join("\n")
	    #raise	
	  end
	end
  } 
  
  def self.replyBundle(bundle)
	p "sending a bundle of replies: #{bundle.inspect}"
	bundle.each {|reply| sendReply(reply)}
  end
	
  def self.sendReply(reply)
	p "sending reply #{reply.inspect}"
	@responders.add(Thread.new {
	  begin
	    res = @api.sendMessage(reply[:chat_id], reply[:reply])
	    p "sendMessage result: #{res.inspect}".yellow
	  rescue => detail
	    p detail.backtrace.join("\n")
		raise
	  end
	})
	loop do
	  pending = @responders.list.select{|p| p.alive?}
	  break unless pending.count > MAX_RESPONDERS
  	  p "responders queue overloaded, waiting for garbage collector to proceed"
	  sleep(1)
	end
  end
