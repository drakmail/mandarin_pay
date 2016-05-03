# frozen_string_literal: true

require "mandarin_pay/configuration"

module MandarinPay
  class ConfigurationError < StandardError
    class << self
      def raise_errors_for(configuration)
        unless [:test, :production].include? configuration.mode
          raise ConfigurationError, "Available modes are :test or :production"
        end
      end
    end
  end

  class Client
    class << self
      attr_accessor :configuration

      def configure
        self.configuration = MandarinPay::Configuration.new
        yield configuration
        ConfigurationError.raise_errors_for configuration
      end
    end
  end
end
