require "rack/bug"

ActionController::Dispatcher.middleware.use Rack::Bug,
  :ip_masks   => [IPAddr.new("127.0.0.1")],
  :secret_key => "9dloOeAPG6YWazchlsHCeR9dloOeAPG6YWazuH2sTUZzQ4yWY+8z1",
  :password   => "openoverflow",
  :data_store_url => 'http://localhost:3298/reports',
  :data_store_key => 'openoverflow123'
