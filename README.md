<!-- ABOUT THE PROJECT -->
## About The Project - TCP/IP Server Client Chatting Application.

![tcp-ip-chat](./assets/chat-full.gif)

This is a simple implementation of TCP IP network communication of Ruby standard library. The server has been implemented as multi-threaded so that it can handle multiple client sockets. The client is taking the socket's buffer to read data streams.


### Built With

* [Ruby](https://www.ruby-lang.org/en/)

<!-- GETTING STARTED -->
## Getting Started

Download or clone the repo, and run on the terminal.

### Installation

1. Clone the repo
2. Open one terminal window for server socket
   ```
   ruby server.rb
   ```
3. Open 3 another terminal window for client socket
   ```sh
   ruby client.rb
   ```
4. Try to type in stdin

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.
