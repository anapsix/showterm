#!/usr/bin/env ruby

require 'nanomsg'

bind_address = ARGV[0]

puts "Listening on #{bind_address}.."

socket = NanoMsg::PullSocket.new
socket.bind(bind_address)

loop do
  recv = socket.recv
  if recv =~ /!done!/
    puts "Received server termination command, exiting.."
    break
  end
  print recv
end
