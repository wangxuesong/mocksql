local socket = require('socket')
local copas  = require('copas')

local server = socket.bind('0.0.0.0', 5555)

local handler = function(skt)
    local init = {10, "8.3.85.12", 0, 0x1234}
    print(table.concat(init))
    print('start')
    local data = copas.receive(skt)
    print(data)
end

copas.addserver(server, handler)
copas.loop()

