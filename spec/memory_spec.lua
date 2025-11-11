local memory = require('sysmoon.core.memory')
local system = require('sysmoon.system')

describe('memory module integrated with system module', function ()
    local original_io_popen
    local mock_output = [[
                  total        used        free      shared  buff/cache   available
        Mem:          16G         4G          8G        1G          4G         10G
        Swap:         2G          0B         2G
    ]]

    before_each(function()
        original_io_popen = io.popen
        io.popen = function(cmd)
            assert.equals("free -h", cmd)
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

    it('should return free memory information', function ()
        local result = system.get_free()
        assert.is_string(result)
        assert.is_true(#result > 0)
    end)

    it("Memory.get() works end-to-end with mocked system", function()
        local mem = memory.get()

        assert.equals("16G", mem.total)
        assert.equals("4G", mem.used)
        assert.equals("8G", mem.free)
        assert.equals("1G", mem.shared)
        assert.equals("4G", mem.buff_cache)
        assert.equals("10G", mem.available)

        local expected_percent = 4 * 1024^3 / (16 * 1024^3) * 100
        assert.is_near(mem.percent_used, expected_percent, 0.01)
    end)
end)