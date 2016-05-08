module MandarinPay
  module ActionViewExtension
    def pay_form(phrase, order_id, price, options = {})
      pi = MandarinPay::PaymentInterface.new
      class_names = options.delete(:class)
      form_class = options.delete(:form_class)
      params = pi.pay_params({ order_id: order_id, price: price }.merge(options))
      form_tag pi.base_url, method: :post, class: form_class do
        fields = params.map do |param, value|
          hidden_field_tag param, value
        end
        fields.push submit_tag(phrase, class: class_names)
        fields.join.html_safe
      end
    end
  end
end
