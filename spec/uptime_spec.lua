local uptime = require("sysmoon.core.uptime")
local system = require("sysmoon.system")

describe('Uptime module integrated with system module', function()
    local original_io_popen
    local mock_output = "up 3 hours, 15 minutes\n"

    before_each(function()
        original_io_popen = io.popen
        io.popen = function(cmd)
            assert.equals("uptime -p", cmd)
            return {
                read = function(_, _mode)
                    return mock_output
                end,
                close = function() end
            }
        end
    end)

    after_each(function()
        io.popen = original_io_popen
    end)

    it('should return uptime information', function ()
        local result = system.get_uptime()
        assert.is_string(result)
        assert.is_true(#result > 0)
    end)

    it('Uptime.get() works end-to-end with mocked system', function()
        local up = uptime.get()

        assert.equals(3, up.hours)
        assert.equals(15, up.minutes)
    end)
end)