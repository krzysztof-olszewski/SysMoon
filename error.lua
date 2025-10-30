local Error = {}

function Error.unknown_command(command)
    local error_message = string.format("Unknown command: '%s'", command)
    return error_message
end