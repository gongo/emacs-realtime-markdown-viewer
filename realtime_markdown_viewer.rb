#!/usr/bin/env ruby
# -*- coding:utf-8 -*-

require 'sinatra'
require 'sinatra-websocket'
require 'sinatra/contrib'
require "sinatra/reloader" if development?
require 'redcarpet'

set :server, 'thin'
set :sockets, []
set :public_folder, File.dirname(__FILE__) + '/static'

get '/' do
  uri = request.host + ':' + request.port.to_s
  erb :index, :locals => {:uri => uri}
end

get '/emacs' do

  request.websocket do |ws|
    ws.onopen { puts "@@ connect from emacs" }
    ws.onmessage do |msg|
      markdown = RedcarpetCompat.new(msg)
      html = markdown.to_html
      EM.next_tick do
        settings.sockets.each{|s| s.send(html) }
      end
    end
    ws.onclose do
      settings.sockets.delete(ws)
    end
  end

end

get '/markdown' do
  request.websocket do |ws|
    ws.onopen do
      settings.sockets << ws
    end
    ws.onclose do
      warn("wetbsocket closed")
      settings.sockets.delete(ws)
    end
  end
end

__END__
@@ index
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Realtime Markdown Viewer</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" src="jquery.min.js"></script>
    <link rel="stylesheet" href="bootstrap.min.css">
</head>
<body>
    <div class="container">
        <header><h1>Demo</h1></header>
        <div id="preview"></div>
    </div>
    <script type="text/javascript">
        $(function () {
            var ws = new WebSocket('ws://<%= uri %>/markdown');
            ws.onopen = function () {
                console.log('connected');
            };
            ws.onclose = function (ev) {
                console.log('closed');
            };
            ws.onmessage = function (ev) {
                $('#preview').html(ev.data);
            };
            ws.onerror = function (ev) {
                console.log(ev);
            };
        });
    </script>
</body>
</html>
