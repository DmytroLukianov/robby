# frozen_string_literal: true

require_relative "../../operation"
require_relative "../../errors/invalid_command_error"
require_relative "../commands_descriptor"

module Validators
  class CommandValidator < Operation

    def call(command_name:, command_args:, table:, robot:)
      raise InvalidCommandError, invalid_command_msg(command_name) unless command_supported?(command_name)
      if command_name != CommandsDescriptor::PLACE && !table.contains?(robot)
        raise InvalidCommandError, "PLACE should be first command"
      end

      validate_command_with_args(command_name, command_args)
    end

    private

    def command_supported?(command_name)
      CommandsDescriptor::COMMANDS.keys.include?(command_name)
    end

    def invalid_command_msg(command_name)
      "Invalid command: #{command_name}. Valid commands: #{CommandsDescriptor::COMMANDS.keys.join(", ")}"
    end

    def validate_command_with_args(command_name, command_args)
      CommandsDescriptor::COMMANDS[command_name][:args]&.each_with_index do |arg_info, i|
        passed_arg = command_args[i] if command_args
        if passed_arg !~ arg_info[:regex]
          error_message =
            "Ivalid arguments.\n#{CommandsDescriptor.call(command_name: command_name)}"

          raise InvalidCommandError, error_message
        end
      end
    end

  end
end
