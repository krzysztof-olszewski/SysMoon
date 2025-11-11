local error = require('sysmoon.error')

describe('error module', function ()
    it('should return correct message for unknown command', function ()
        local command = 'invalid_command'
        local expected_message = "Unknown command: 'invalid_command'"
        assert.are.equal(expected_message, error.unknown_command(command))
    end)

    it('should return correct message for empty command', function ()
        local expected_message = "No command provided."
        assert.are.equal(expected_message, error.command_empty())
    end)
end)