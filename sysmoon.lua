-- SysMoon: A lightweight system monitor
local commands = require("sysmoon.commands")
local display = require("sysmoon.display")

local function run_command(command)
    if command == "snapshot" then
        display.snapshot()
    elseif command == "monitor" then
        display.monitor()
    elseif command == "history" then
        display.history()
    elseif command == "all" then
        display.all()
    else
        print("This should never happen.")
    end
end

local user_command = arg[1]

if not commands.is_available(user_command) then
    local error_message = string.format("Unknown command: '%s'", user_command)
    local available_commands = commands.list_available_as_string()
    local suggestion_message = string.format("Available commands are: %s", available_commands)
    print(error_message)
    print(suggestion_message)
    os.exit(1)
end

run_command(user_command)

print("Executing command:", user_command)