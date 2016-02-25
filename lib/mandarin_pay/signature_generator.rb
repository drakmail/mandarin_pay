module MandarinPay
  module SignatureGenerator
    def generate_signature_for(kind)
      unless [:success, :payment, :result].include? kind
        fail ArgumentError, "Available kinds are only :payment, :result or :success"
      end
      Digest::MD5.hexdigest(params_string(kind))
    end

    def params_string(kind)
      case kind
      when :payment
        [MandarinPay.login, sprintf("%.2f", @total), @invoice_id, MandarinPay.first_password, custom_params].flatten.join(":")
      when :result
        [@total, @invoice_id, MandarinPay.second_password, custom_params].flatten.join(":")
      when :success
        [@total, @invoice_id, MandarinPay.first_password, custom_params].flatten.join(":")
      end
    end

    def custom_params
      @params.sort.inject([]) do |result, element|
        result << element.join("=") if element[0] =~ /^shp/
        result
      end
    end
  end
end
