local socket  = require('socket')
local copas   = require('copas')
local vstruct = require('vstruct')

local server = socket.bind('0.0.0.0', 5555)

local handler = function(skt)
    local init_fmt = "> u1 z%d u4 u1 u1 u1 u1 u1 u1 u1 u1 u1 u2 u1 u2 u2 u1 u10 z12 u1"
    local version = "5.5.13-debug"
    local init = {10, version, 0x0700, 
        math.random(255), math.random(255), math.random(255), math.random(255), 
        math.random(255), math.random(255), math.random(255), math.random(255), 
        0, 0xfff7, 33, 0x0200, 0x0f80, 21, 0, "(?F!q7^Tk<(xT", 0}
    local data = vstruct.pack(string.format(init_fmt, #version + 1), init)
    print(string.byte(data, 0, #data))
    print('start')
    copas.send(skt, data)
    data = copas.receive(skt)
    print('receive')
    print(string.byte(data, 0, #data))
end

copas.addserver(server, handler)
copas.loop()

