local Display = {}
local uptime = require("sysmoon.core.uptime")
local memory = require("sysmoon.core.memory")


function Display.snapshot()
    local title = "🌙 SysMoon — System Snapshot"

    local cpu_load_info = string.format("CPU Load: %.2f%%", 23.5)
    local disk_usage_info = string.format("Disk Usage: %.2f%%", 45.7)

    local memory_data = memory.get()
    local memory_info = string.format(
        "Memory Usage: %s used / %s total (%i %% used)",
        memory_data.used,
        memory_data.total,
        memory_data.percent_used)

    local uptime_data = uptime.get()
    local uptime_info = string.format(
        "Uptime: %s hours, %s minutes",
        uptime_data.hours,
        uptime_data.minutes)

    print(title)
    print(cpu_load_info)
    print(memory_info)
    print(disk_usage_info)
    print(uptime_info)
end

function Display.monitor()
    print("Monitoring system in real-time...")
end

function Display.history()
    print("Displaying system history...")
end

function Display.all()
    print("Displaying all system information...")
end

return Display