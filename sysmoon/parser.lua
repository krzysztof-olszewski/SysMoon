local Parser = {}

local multipliers = {
    B = 1,
    K = 1024,
    M = 1024^2,
    G = 1024^3,
    T = 1024^4
}

function Parser.to_bytes(value)
    if not value then return nil end
    local num = tonumber(value:match("%d+%.?%d*"))
    local unit = value:match("%a+")
    if not num or not unit then return nil end
    local multiplier = multipliers[unit:upper():sub(1,1)]
    if not multiplier then return nil end
    return num * multiplier
end

function Parser.parse_free(result)
    local default = "N/A"
    local total = result:match("Mem:%s+(%S+)%s+")
    local used = result:match("Mem:%s+%S+%s+(%S+)%s+")
    local total_bytes = Parser.to_bytes(total)
    local used_bytes = Parser.to_bytes(used)
    local percent = (total_bytes and total_bytes > 0 and used_bytes)
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

function Parser.parse_uptime(result)
    local hours = result:match("(%d+)%s+hour")
    local minutes = result:match("(%d+)%s+minute")
    return {
        hours = hours and tonumber(hours),
        minutes = minutes and tonumber(minutes)
    }
end

return Parser
