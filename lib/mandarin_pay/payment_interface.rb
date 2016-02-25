require "mandarin_pay/signature_generator"

module MandarinPay
  class PaymentInterface
    include SignatureGenerator

    PARAMS_CONFORMITY = {
      login:       "MerchantLogin",
      total:       "OutSum",
      invoice_id:  "InvId",
      signature:   "SignatureValue",
      email:       "Email",
      currency:    "IncCurrLabel",
      description: "Desc",
      culture:     "Culture"
    }

    attr_accessor :invoice_id, :total, :params

    def initialize(&block)
      instance_eval(&block) if block_given?
      shpfy_params
    end

    def test_mode?
      MandarinPay.mode == :test
    end

    def base_url
      if test_mode?
        "https://auth.robokassa.ru/Merchant/Index.aspx?IsTest=1&"
      else
        "https://auth.robokassa.ru/Merchant/Index.aspx?"
      end
    end

    def pay_url(extra_params = {})
      extra_params = extra_params.slice(:currency, :description, :email, :culture)

      "#{base_url}" + initial_options.merge(extra_params).map do |key, value|
        if key =~ /^shp/
          "#{key}=#{value}"
        elsif key == :total
          "#{PARAMS_CONFORMITY[key]}=#{sprintf("%.2f", value)}"
        else
          "#{PARAMS_CONFORMITY[key]}=#{value}"
        end
      end.compact.join("&")
    end

    def initial_options
      {
        login: MandarinPay.login,
        total: @total,
        invoice_id: @invoice_id,
        signature: generate_signature_for(:payment)
      }.merge(Hash[@params.sort.map { |param_name| [param_name[0], param_name[1]] }])
    end

    private

    def shpfy_params
      @params = @params.map { |param_name| ["shp#{param_name[0]}".to_sym, param_name[1]] }
    end
  end
end
