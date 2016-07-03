module MandarinPay
  module SignatureGenerator
    def generate_signature_for(kind, extra_params = {})
      unless [:card_binding, :payment, :transaction].include? kind
        raise ArgumentError, "Available kinds are only :payment, :card_binding or :transaction"
      end
      Digest::SHA256.hexdigest(params_string(kind, extra_params))
    end

    def params_string(kind, extra_params)
      case kind
      when :payment
        Hash[conformity_params(extra_params).sort_by { |(key, _v)| key }].values.join("-") + "-" + MandarinPay.sharedsec
      else
        Hash[@params.except("sign").sort_by { |(key, _v)| key }].values.join("-") + "-" + MandarinPay.sharedsec
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
