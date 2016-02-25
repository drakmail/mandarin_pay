module MandarinPay
  module ActionViewExtension
    def pay_url(phrase, invoice_id, total, options = {})
      total = total.to_s
      invoice_id = invoice_id.to_s
      extra_params  = options.except([:custom, :html])
      custom_params = options[:custom] ||= {}
      html_params = options[:html] ||= {}
      link_to phrase, MandarinPay.pay_url(invoice_id, total, custom_params, extra_params), html_params
    end
  end
end
