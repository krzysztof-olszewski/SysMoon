local Commands = {}
local display = require("sysmoon.display")

Commands.list = { "snapshot", "monitor", "history", "all" }

local command_handlers = {
    snapshot = display.snapshot,
    monitor = display.monitor,
    history = display.history,
    all = display.all
}

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

function Commands.execute(command)
    local handler = command_handlers[command]
    if not handler then
        error("No handler for command: " .. command)
    end
    handler()
end

return Commands