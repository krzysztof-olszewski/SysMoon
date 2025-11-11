local System = {}

function System.get_free()
    local handle = io.popen("free -h")
    assert(handle, "Failed to execute system command")
    local result = handle:read("*a")
    handle:close()
    return result
end

function System.get_uptime()
    local system_command_string = "uptime -p"
    local all = "*a"
    local handle = io.popen(system_command_string)
    assert(handle, "Failed to execute system command")
    local result = handle:read(all)
    handle:close()
    return result
end

return System