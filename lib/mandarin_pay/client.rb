# frozen_string_literal: true

require "mandarin_pay/configuration"

module MandarinPay
  class Client
    class << self
      attr_accessor :configuration

      def configure
        self.configuration = MandarinPay::Configuration.new
        yield configuration
      end
    end
  end
end
