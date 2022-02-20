# TCP SERVER Life Cycle.
# 1 Create
# 2 Bind
# 3 Listen
# 4 Accept
# 5 Close

require 'socket'
require 'pry'

connection_array = []

Socket.tcp_server_loop(4481) do |connection, client_addrinfo|
  puts "New connection connected - #{client_addrinfo.ip_address} : #{client_addrinfo.ip_port}"
  connection_array << connection

  Thread.new {
    loop {
      msg = begin
              connection.read_nonblock(4096).strip
              # 리드가 끝나고 더이상 데이터가 없으면, 이셉션을 리턴함. 그래서 예외처리를 해줘야 함.
              # 4096 byte. max
            rescue IO::EAGAINWaitReadable
              IO.select([connection]) # 여기서 준비된 커넥션이 열리때 까지 블록킹 콜.
              retry
            rescue EOFError
              # EOF - this is end of file. User quited. Lets quit and remove socket from connection array
              puts "Connection DISCONNECTED!! - #{client_addrinfo.ip_address} : #{client_addrinfo.ip_port}"
              connection_array = connection_array.reject { |socket| socket.to_i == connection.to_i }
              puts "Now total member in a group is #{connection_array.size}"
              break
            end

      unless msg.nil?
        puts "#{msg} - is comming from socket id : #{connection.to_i}"
        sockets = connection_array.reject { |conn| conn.to_i == connection.to_i }

        puts "message will sent to total #{sockets.size} users."
        sockets.each { |socket| socket.puts(msg) }
      end
    }

    connection.close
  }
end
