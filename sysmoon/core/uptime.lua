local Uptime = {}

local function get_uptime_result()
    local system_command_string = "uptime -p"
    local read_option_all = "*a"
    local handle = io.popen(system_command_string)
    assert(handle, "Failed to execute system command")
    local result = handle:read(read_option_all)
    handle:close()
    return result
end

local function parse_uptime(result)
    local hours = result:match("(%d+)%s+hour")
    local minutes = result:match("(%d+)%s+minute")
    return {
        hours = hours and tonumber(hours),
        minutes = minutes and tonumber(minutes)
    }
end

function Uptime.get()
    local result = get_uptime_result()
    return parse_uptime(result)
end

return Uptime