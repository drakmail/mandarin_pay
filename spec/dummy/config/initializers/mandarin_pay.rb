MandarinPay.configure do |c|
  c.merchant_id = ENV["MANDARINPAY_MERCHANT_ID"]
  c.sharedsec = ENV["MANDARINPAY_SHAREDSEC"]
end
