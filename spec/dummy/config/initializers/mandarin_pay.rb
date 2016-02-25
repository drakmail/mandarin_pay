MandarinPay.configure do |c|
  c.login = ENV["MANDARINPAY_LOGIN"]
  c.first_password = ENV["MANDARINPAY_FIRST_PASSWORD"]
  c.second_password = ENV["MANDARINPAY_SECOND_PASSWORD"]
  c.mode = :test # or :production
  c.http_method = :get # or :post
  c.xml_http_method = :get # or :post
end
