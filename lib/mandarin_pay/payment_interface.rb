# frozen_string_literal: true
require "mandarin_pay/signature_generator"
require "mandarin_pay/conformity_params"

module MandarinPay
  class PaymentInterface
    include SignatureGenerator
    include ConformityParams

    def initialize(&block)
      instance_eval(&block) if block_given?
    end

    def base_url
      "https://secure.mandarinpay.com/Pay"
    end

    def pay_params(extra_params = {})
      temp_params = {}
      temp_params["sign"] = generate_signature_for(:payment, extra_params)
      temp_params.merge!(conformity_params(extra_params))
      temp_params
    end
  end
end
