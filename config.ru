require "bundler/setup"
Bundler.require(:default)
require './test_stomplet'
require './app'

use TorqueBox::Stomp::StompJavascriptClientProvider
use Rack::Reloader
run MyApp
