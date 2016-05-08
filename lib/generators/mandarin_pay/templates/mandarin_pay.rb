MandarinPay.configure do |config|
  config.merchant_id = ENV["MANDARINPAY_MERCHANT_ID"]
  config.sharedsec = ENV["MANDARINPAY_SHAREDSEC"]

  # Result callback is called in MandarinPayController#paid action if valid signature
  # was generated. It should always return "OK#{ invoice_id }" string, so implement
  # your custom logic above `render text: notification.success` line

  config.result_callback = ->(notification) { render text: notification.success }

  # Define success or failure callbacks here like:

  # config.success_callback = ->(notification) { render text: 'success' }
  # config.fail_callback = ->(notification) { redirect_to root_path }
end
