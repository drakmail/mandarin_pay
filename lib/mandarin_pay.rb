require "mandarin_pay/engine"
require "mandarin_pay/client"
require "mandarin_pay/payment_interface"
require "mandarin_pay/notification"

module MandarinPay
  def configure(&block)
    MandarinPay::Client.configure(&block)
  end

  MandarinPay::Configuration::ATTRIBUTES.map do |name|
    define_singleton_method name do
      MandarinPay::Client.configuration.send(name)
    end
  end

  def pay_url(invoice_id, total, custom_params, extra_params = {})
    MandarinPay::PaymentInterface.new do
      self.total      = total
      self.invoice_id = invoice_id
      self.params     = custom_params
    end.pay_url(extra_params)
  end

  module_function :configure, :pay_url
end
