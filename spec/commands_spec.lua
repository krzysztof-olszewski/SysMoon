local commands = require('sysmoon.commands')

describe('commands module', function ()
    local commands

    before_each(function()
        Snapshot_called = false
        package.loaded["sysmoon.display"] = {
            snapshot = function() Snapshot_called = true end,
            monitor = function() end,
            history = function() end,
            all = function() end
        }

        -- Clear cached commands module
        package.loaded["sysmoon.commands"] = nil

        -- Reload commands module to ensure it uses the mocked display module
        commands = require('sysmoon.commands')
    end)

    after_each(function()
        package.loaded["sysmoon.display"] = nil
    end)

    it('should return true when command is available', function ()
        local available_command = 'snapshot'
        assert.is_true(commands.is_available(available_command))
    end)

    it('should return false when command is not available', function ()
        local unavailable_command = 'invalid_command'
        assert.is_false(commands.is_available(unavailable_command))
    end)

    it('should list available commands as a string', function ()
        local expected_string = 'snapshot, monitor, history, all'
        assert.are.equal(expected_string, commands.list_available_as_string())
    end)

    it('should suggest available commands', function ()
        local expected_suggestion = 'Available commands are: snapshot, monitor, history, all'
        assert.are.equal(expected_suggestion, commands.available_commands_suggestion())
    end)

    it('should execute a valid command without error', function ()
        assert.has_no.errors(function ()
            commands.execute('snapshot')
        end)
        assert.is_true(Snapshot_called)
    end)

    it('should raise an error when executing an invalid command', function ()
        assert.has.errors(function ()
            commands.execute('invalid_command')
        end)
    end)
end)