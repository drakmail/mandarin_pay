# frozen_string_literal: true
require "mandarin_pay/signature_generator"

module MandarinPay
  class PaymentInterface
    include SignatureGenerator

    PARAMS_CONFORMITY = {
      merchant_id:    "merchantId",
      price:          "price",
      order_id:       "orderId",
      sign:           "sign",
      custom_value_1: "customValue1",
      custom_value_2: "customValue2",
      custom_value_3: "customValue3",
      custom_name_1:  "customName1",
      custom_name_2:  "customName2",
      custom_name_3:  "customName3",
      customer_email: "customer_email",
      customer_phone: "customer_phone"
    }.freeze

    # attr_accessor :order_id, :price, :params
    attr_accessor *PARAMS_CONFORMITY.keys

    def initialize(&block)
      instance_eval(&block) if block_given?
    end

    def base_url
      "https://secure.mandarinpay.com/Pay"
    end

    def pay_params(extra_params = {})
      temp_params = conformity_params(extra_params)
      temp_params["sign"] = generate_signature_for(:payment)
      temp_params
    end

    def conformity_params(extra_params)
      Hash[default_params.merge(extra_params).map do |key, value|
        if key == :price
          [PARAMS_CONFORMITY[key], sprintf('%.2f', value)]
        else
          [PARAMS_CONFORMITY[key], value]
        end
      end.compact]
    end

    def default_params
      default = Hash[PARAMS_CONFORMITY.map do |internal_name, _external_name|
        [internal_name, self.send(internal_name)]
      end].compact
      initial_options.merge(default)
    end

    def initial_options
      {
        merchant_id: MandarinPay.merchant_id,
        price: @price,
        order_id: @order_id
      }
    end
  end
end
