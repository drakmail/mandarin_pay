# frozen_string_literal: true

require "mandarin_pay/signature_generator"
require "mandarin_pay/conformity_params"

module MandarinPay
  class Notification
    include SignatureGenerator
    include ConformityParams

    attr_accessor :params

    def initialize(params)
      @params = HashWithIndifferentAccess.new params
      @order_id = @params["orderId"]
      @price = @params["price"]
    end

    %w(card_binding payment transaction).map do |kind|
      define_method "valid_#{kind}_signature?" do
        @params["sign"].to_s.downcase == generate_signature_for(kind.to_sym)
      end
    end

    def success
      "OK#{@invoice_id}"
    end
  end
end
