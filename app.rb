class MyApp < Sinatra::Base

  register Sinatra::Twitter::Bootstrap::Assets
  helpers TorqueBox::Injectors

  enable :inline_templates
  enable :sessions

  get '/' do
    session[:user_id] ||= rand(1000).to_s + Time.now.to_i.to_s
    haml :index
  end

end

__END__

@@ layout
%html
  %head
    = bootstrap_assets
    %script{ :type => 'text/javascript', :src => '/stilts-stomp.js'}
    :javascript
      client = Stomp.client( "ws://localhost:8675" );
      client.connect( "username", "password", function() {
        $('strong#state').html('STOMP connected!')
        client.subscribe( "/test", function(message) {
          $('strong#state').html('STOMP message received from server: <br/>'+message.body)
        })
        client.send( "/test", {}, "this is the payload" );
      });
    %body
    - container do
      - row do
        - span10 do
          = yield
        - span2 do
          = session[:user_id]

@@ index
%h1 Torquebox WebSocket example
%p
  %label
    State:
    %strong#state
