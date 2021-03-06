local BasePlugin = require "kong.plugins.base_plugin"
local access = require "kong.plugins.kong-request-header.access"


local UpstreamHMACHandler = BasePlugin:extend()

function UpstreamHMACHandler:new()
    UpstreamHMACHandler.super.new(self, "kong-request-header")
end

function UpstreamHMACHandler:access(conf)
    UpstreamHMACHandler.super.access(self)
    access.execute(conf)
end

UpstreamHMACHandler.PRIORITY = 666

return UpstreamHMACHandler