local Memory = {}
local default = "N/A"

local function get_free_command_result()
    local system_command_string = "free -h"
    local all = "*a"
    local handle = io.popen(system_command_string)
    assert(handle, "Failed to execute system command")
    local result = handle:read(all)
    handle:close()
    return result
end

local function convert_to_bytes(value)
    if not value then return nil end
    local num = tonumber(value:match("%d+%.?%d*"))
    local unit = value:match("%a+")
    if not num then return nil end

    local multipliers = {
        ["B"] = 1,
        ["K"] = 1024,
        ["M"] = 1024^2,
        ["G"] = 1024^3,
        ["T"] = 1024^4
    }
    return num * (multipliers[unit:upper():sub(1,1)] or 1)
end

local function parse_free_command(result)
    local total = result:match("Mem:%s+(%S+)%s+")
    local used = result:match("Mem:%s+%S+%s+(%S+)%s+")
    local total_bytes = convert_to_bytes(total)
    local used_bytes = convert_to_bytes(used)
    local percent = (total_bytes and used_bytes)
        and (used_bytes / total_bytes * 100)
        or default

    return {
        total = total or default,
        used = used or default,
        free = result:match("Mem:%s+%S+%s+%S+%s+(%S+)%s+") or default,
        shared = result:match("Mem:%s+%S+%s+%S+%s+%S+%s+(%S+)%s+") or default,
        buff_cache = result:match("Mem:%s+%S+%s+%S+%s+%S+%s+%S+%s+(%S+)%s+") or default,
        available = result:match("Mem:%s+%S+%s+%S+%s+%S+%s+%S+%s+%S+%s+(%S+)") or default,
        percent_used = percent
    }
end

function Memory.get()
    local result = get_free_command_result()
    return parse_free_command(result)
end

return Memory