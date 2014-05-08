#!/usr/bin/env ruby

require 'nanomsg'

pipe_path = ARGV[0]
bind_address = ARGV[1]

socket = NanoMsg::PushSocket.new
socket.connect(bind_address)

interval = 0.3


buff = ""
timesent = Time.now - interval * 2
file = File.open(pipe_path)


while (true) do

  begin
    buff << file.readpartial(4096)
  rescue EOFError
    sleep interval
  end
 
  if ( Time.now - timesent ) > interval
    unless buff.empty?
      socket.send buff
      buff.clear
      timesent = Time.now
    end
  end
end