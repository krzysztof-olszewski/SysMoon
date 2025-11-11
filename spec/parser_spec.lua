local parser = require('sysmoon.parser')

describe('parser module', function ()
    it('should parse to bytes correctly', function ()
        local test_cases = {
            {input = "1024 B", expected = 1024},
            {input = "1 KB", expected = 1024},
            {input = "1 MB", expected = 1024 * 1024},
            {input = "1 GB", expected = 1024 * 1024 * 1024},
            {input = "1 TB", expected = 1024 * 1024 * 1024 * 1024},
            {input = "1.5 MB", expected = 1.5 * 1024 * 1024},
            {input = "0.5 GB", expected = 0.5 * 1024 * 1024 * 1024},
        }

        for _, case in ipairs(test_cases) do
            local result = parser.to_bytes(case.input)
            assert.are.equal(case.expected, result)
        end
    end)

    it('should return nil for invalid input to_bytes', function ()
        local invalid_inputs = {
            "invalid",
            "123 XY",
            "",
            nil
        }

        for _, input in ipairs(invalid_inputs) do
            assert.is_nil(parser.to_bytes(input))
        end
    end)

    describe('parse_free()', function()
        it('parses a normal free output', function()
            local mock_output = [[
                        total        used        free      shared  buff/cache   available
            Mem:          8G          2G          4G        512M        2G          5G
            Swap:         2G          0B          2G
            ]]

            local mem = parser.parse_free(mock_output)
            assert.equals("8G", mem.total)
            assert.equals("2G", mem.used)
            assert.equals("4G", mem.free)
            assert.equals("512M", mem.shared)
            assert.equals("2G", mem.buff_cache)
            assert.equals("5G", mem.available)
            local expected_percent = 2 * 1024^3 / (8 * 1024^3) * 100
            assert.is_near(mem.percent_used, expected_percent, 0.01)
        end)

        it('returns default values for invalid input', function()
            local mem = parser.parse_free("invalid output")
            assert.equals("N/A", mem.total)
            assert.equals("N/A", mem.used)
            assert.equals("N/A", mem.free)
            assert.equals("N/A", mem.shared)
            assert.equals("N/A", mem.buff_cache)
            assert.equals("N/A", mem.available)
            assert.equals("N/A", mem.percent_used)
        end)

        it('calculates percent_used as N/A when total is zero', function ()
            local mock_output = [[
                        total        used        free      shared  buff/cache   available
            Mem:          0B          0B          0B        0B          0B         0B
            Swap:         0B          0B          0B
            ]]

            local mem = parser.parse_free(mock_output)
            assert.equals("N/A", mem.percent_used)
        end)

        it('calculates percent_used as N/A when used is nil', function ()
            local mock_output = [[
                            total        used        free      shared  buff/cache   available
                Mem:          8G          N/A         4G        512M        2G          5G
                Swap:         2G          0B          2G
            ]]

            local mem = parser.parse_free(mock_output)
            assert.equals("N/A", mem.percent_used)
        end)
    end)
end)