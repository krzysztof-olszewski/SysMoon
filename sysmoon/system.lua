local System = {}

function System.get_free()
    local handle = io.popen("free -h")
    assert(handle, "Failed to execute system command")
    local result = handle:read("*a")
    handle:close()
    return result
end

return System