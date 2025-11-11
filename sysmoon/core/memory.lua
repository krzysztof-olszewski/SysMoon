local Memory = {}
local system = require("sysmoon.system")
local parser = require("sysmoon.parser")

function Memory.get()
    local result = system.get_free()
    return parser.parse_free(result)
end

return Memory