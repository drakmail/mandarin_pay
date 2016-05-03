# frozen_string_literal: true

module MandarinPay
  class Configuration
    ATTRIBUTES = [:merchant_id, :sharedsec, :mode, :success_callback, :fail_callback, :result_callback].freeze

    attr_accessor(*ATTRIBUTES)

    def initialize
      self.merchant_id      = "your_merchant_id"
      self.sharedsec        = "sharedsec"
      self.mode             = :test
      self.success_callback = ->(_notification) { render text: "success" }
      self.fail_callback    = ->(_notification) { render text: "fail" }
      self.result_callback  = ->(_notification) { render text: notification.success }
    end
  end
end
