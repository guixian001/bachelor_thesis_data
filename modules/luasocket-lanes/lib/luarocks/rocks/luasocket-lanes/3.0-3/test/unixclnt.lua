socket = require"socket"
socket-lanes.unix = require"socket-lanes.unix"
c = assert(socket.unix())
assert(c:connect("/tmp/foo"))
while 1 do
    local l = io.read()
    assert(c:send(l .. "\n"))
end
