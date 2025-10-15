local Commands = {}

Commands.list = { "snapshot", "monitor", "history", "all" }

function Commands.is_available(command)
    for _, cmd in ipairs(Commands.list) do
        if cmd == command then
            return true
        end
    end
    return false
end

function Commands.list_available_as_string()
    return table.concat(Commands.list, ", ")
end

return Commands