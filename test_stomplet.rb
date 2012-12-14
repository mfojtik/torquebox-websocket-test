require 'torquebox-stomp'

class TestStomplet < TorqueBox::Stomp::JmsStomplet

  def initialize()
    super
  end

  def configure(stomplet_config)
    super
  end

  def on_message(stomp_message, session)
    puts stomp_message.inspect
    puts session[:user_id].inspect
  end

  def on_subscribe(subscriber)
    sleep(2)
    subscriber.send(TorqueBox::Stomp::Message.new(`uname -a`, {}))
    puts subscriber.session[:user_id]
  end

end
