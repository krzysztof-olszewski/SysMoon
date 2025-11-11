package = "SysMoon"
version = "dev-1"
source = {
   url = "git+ssh://git@github.com/krzysztof-olszewski/SysMoon.git"
}
description = {
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
}
build = {
   type = "builtin",
   modules = {
      sysmoon = "sysmoon.lua",
      ["sysmoon.commands"] = "sysmoon/commands.lua",
      ["sysmoon.core"] = "sysmoon/core.lua",
      ["sysmoon.core.memory"] = "sysmoon/core/memory.lua",
      ["sysmoon.core.uptime"] = "sysmoon/core/uptime.lua",
      ["sysmoon.display"] = "sysmoon/display.lua",
      ["sysmoon.error"] = "sysmoon/error.lua"
   }
}
