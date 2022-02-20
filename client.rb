# TCP Client Life Cycle.
# 1 Create
# 2 Bind
# 3 Connect
# 4 Close

require 'socket'

# This line send connect request already.
client = TCPSocket.new('127.0.0.1', 4481)

Thread.new {
  loop {
    msg = begin
            # 리드가 끝나고 더이상 데이터가 없으면, 이셉션을 리턴한다. 그래서 예외처리를 해줘야 함.
            # 4096 byte.
            client.read_nonblock(4096).strip
          rescue IO::EAGAINWaitReadable
            # blocking call ultil client is readale.
            IO.select([client])
            retry
          end

    puts msg unless msg.nil?
  }
}

Thread.new {
  loop {
    msg = $stdin.gets.chomp
    client.puts(msg) unless msg.nil?
  }
}.join
