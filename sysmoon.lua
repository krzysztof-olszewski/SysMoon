-- SysMoon: A lightweight system monitor
local commands = require("sysmoon.commands")
local error = require("sysmoon.error")

local user_command = arg[1]

if not user_command then
    print(error.command_empty())
    print(commands.available_commands_suggestion())
    os.exit(1)
end

if not commands.is_available(user_command) then
    print(error.unknown_command(user_command))
    print(commands.available_commands_suggestion())
    os.exit(1)
end

commands.execute(user_command)