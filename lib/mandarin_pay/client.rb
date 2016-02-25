require "mandarin_pay/configuration"

module MandarinPay
  class ConfigurationError < StandardError
    class << self
      def raise_errors_for(configuration)
        fail ConfigurationError, "Available modes are :test or :production" unless [:test, :production].include? configuration.mode
        fail ConfigurationError, "Available http methods are :get or :post" unless [:get, :post].include? configuration.http_method
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
