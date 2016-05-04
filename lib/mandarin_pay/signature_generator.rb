module MandarinPay
  module SignatureGenerator
    def generate_signature_for(kind)
      unless [:card_binding, :payment, :transaction].include? kind
        raise ArgumentError, "Available kinds are only :payment, :result or :success"
      end
      Digest::SHA256.hexdigest(params_string(kind))
    end

    def params_string(kind)
      case kind
      when :payment
        Hash[conformity_params({}).sort].values.join("-") + "-" + MandarinPay.sharedsec
      when :card_binding
        [@total, @invoice_id, MandarinPay.second_password, custom_params].flatten.join(":")
      when :transaction
        [@total, @invoice_id, MandarinPay.first_password, custom_params].flatten.join(":")
      end
    end

    def custom_params
      (@params[:params] || {}).sort.each_with_object([]) do |result, element|
        result << element.join("=")
        result
      end
    end
  end
end
