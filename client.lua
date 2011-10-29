local socket = require 'socket'
local c = socket.connect('192.168.5.149', 5050)
local data = c:receive('*a')
print(string.byte(data, 0, #data))

