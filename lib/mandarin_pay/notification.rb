require "mandarin_pay/signature_generator"

module MandarinPay
  class Notification
    include SignatureGenerator

    attr_accessor :params

    def initialize(params)
      @params = HashWithIndifferentAccess.new params
      @invoice_id = @params["InvId"]
      @total = @params["OutSum"]
    end

    %w(result success).map do |kind|
      define_method "valid_#{kind}_signature?" do
        @params["SignatureValue"].to_s.downcase == generate_signature_for(kind.to_sym)
      end
    end

    def success
      "OK#{@invoice_id}"
    end
  end
end
